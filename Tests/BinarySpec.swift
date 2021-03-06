////
////  BinarySpec.swift
////  Horus
////
////  Created by Caynan Sousa on 5/27/17.
////  Copyright © 2017 Caynan. All rights reserved.
////
//
//import Quick
//import Nimble
//@testable import Horus
//
//class BinarySpec: QuickSpec {
//
//    override func spec() {
//        describe("BinarySpec") {
//            // MARK: - Initialization
//            context("Initializations") {
//                it("initializes with array literal.") {
//                    let binary: Binary? = [0x63, 0x61, 0x79, 0x6E, 0x61, 0x6E, 0x00]
//                    expect(binary).toNot(beNil())
//                }
//
//                it("initializes with Data object.") {
//                    let data: Data = Data()
//                    let binary: Binary? = Binary(with: data)
//
//                    expect(binary).toNot(beNil())
//                }
//
//                it("initializes with array of bytes (aka UInt8).") {
//                    let dataArray: [UInt8] = [0x63, 0x61, 0x79]
//                    let binary = Binary(with: dataArray)
//
//                    // Correct Size
//                    expect(binary.count).to(equal(3))
//
//                    // Correct Values
//                    expect(binary[0]).to(equal(0x63))
//                    expect(binary[1]).to(equal(0x61))
//                    expect(binary[2]).to(equal(0x79))
//                }
//
//                it("Initializes with an Integer") {
//                    func testSize<T: Integer>(_ number: T) {
//                        let binary = Binary(with: number)
//                        expect(binary.count).to(equal(MemoryLayout.size(ofValue: number)))
//                    }
//                    // for UInts
//                    testSize(UInt.max)
//                    testSize(UInt32.max)
//                    testSize(UInt16.max)
//                    testSize(UInt8.max)
//
//                    // for Ints
//                    testSize(Int.max)
//                    testSize(Int32.max)
//                    testSize(Int16.max)
//                    testSize(Int8.max)
//
//                    // Test values
//                    func testValue<T: Integer>(_ testCase: (number: T, expected: [UInt8]) ) {
//                        let binary = Binary(with: testCase.number)
//                        for i in 0..<testCase.expected.count {
//                            expect(binary[i]).to(equal(testCase.expected[i]))
//                        }
//                    }
//                    // UInts
//                    testValue( (number: UInt8.min, expected: [0x00]) )
//                    testValue( (number: UInt16.min, expected: [0x00, 0x00]) )
//                    testValue( (number: UInt32.min, expected: [0x00, 0x00, 0x00, 0x00]) )
//                    testValue( (number: UInt64.min, expected: [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]) )
//
//                    testValue( (number: UInt8.max, expected: [0xFF]) )
//                    testValue( (number: UInt16.max, expected: [0xFF, 0xFF]) )
//                    testValue( (number: UInt32.max, expected: [0xFF, 0xFF, 0xFF, 0xFF]) )
//                    testValue( (number: UInt64.max, expected: [0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF]) )
//
//                    testValue((number: UInt(0x1234567890), expected: [0x00, 0x00, 0x00, 0x12, 0x34, 0x56, 0x78, 0x90]))
//
//                    // Ints
//                    testValue( (number: Int8.min, expected: [0x80]) )
//                    testValue( (number: Int16.min, expected: [0x80, 0x00]) )
//                    testValue( (number: Int32.min, expected: [0x80, 0x00, 0x00, 0x00]) )
//                    testValue( (number: Int64.min, expected: [0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]) )
//
//                    testValue( (number: Int8.max, expected: [0x7F]) )
//                    testValue( (number: Int16.max, expected: [0x7F, 0xFF]) )
//                    testValue( (number: Int32.max, expected: [0x7F, 0xFF, 0xFF, 0xFF]) )
//                    testValue( (number: Int64.max, expected: [0x7F, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF]) )
//
//                    testValue((number: Int(0x1234567890), expected: [0x00, 0x00, 0x00, 0x12, 0x34, 0x56, 0x78, 0x90]))
//                    // 2-complement bin: 1111 1111 1111 1111 1111 1111 1110 1101 1100 1011 1010 1001 1000 0111 0111 0000
//                    testValue((number: -Int(0x1234567890), expected: [0xFF, 0xFF, 0xFF, 0xED, 0xCB, 0xA9, 0x87, 0x70]))
//                }
//
//                it("Initializes with a hex string.") {
//                    let hexString = "00FF"
//                    guard let binary = Binary(with: hexString) else {
//                        fail("Failed to initialize with \(hexString)")
//                        return
//                    }
//
//                    expect(binary.count).to(equal(2))
//
//                    expect(binary[0]).to(equal(0x00))
//                    expect(binary[1]).to(equal(0xFF))
//
//                    let wrongBin = Binary(with: "XX")
//                    expect(wrongBin).to(beNil())
//                }
//            }
//
//            // MARK: - MutableCollection
//            context("MutableCollection") {
//                it("Should access single element") {
//                    let binary: Binary = [0x00, 0x01, 0x02]
//
//                    expect(binary[0]).to(equal(0x00))
//                    expect(binary[1]).to(equal(0x01))
//                    expect(binary[2]).to(equal(0x02))
//                }
//
//                it("Should change single element") {
//                    var binary: Binary = [0x00, 0x01, 0x02]
//
//                    expect(binary[0]).to(equal(0x00)) // Check old value
//                    binary[0] = 0x42 // Change value
//                    expect(binary[0]).to(equal(0x42)) // Check that it changed
//                }
//
//                it("Should access a range of elements") {
//                    let binary: Binary = [0x00, 0x01, 0x02]
//
//                    let openSlice = binary[0..<binary.count]
//                    expect(openSlice).to(equal(binary))
//
//                    let closedSlice = binary[0...2]
//                    expect(closedSlice).to(equal(binary))
//                }
//
//                it("Should change a range of elements") {
//                    var binary: Binary = [0x00, 0x01, 0x02]
//
//                    binary[0...2] = [0x42, 0x43, 0x44]
//
//                    expect(binary[0]).to(equal(0x42))
//                    expect(binary[1]).to(equal(0x43))
//                    expect(binary[2]).to(equal(0x44))
//                }
//
//                it("Should change a range of elements adding elements") {
//                    var binary: Binary = [0x00, 0x01, 0x02]
//
//                    binary[0..<2] = [0x42, 0x43, 0x44]
//
//                    expect(binary[0]).to(equal(0x42))
//                    expect(binary[1]).to(equal(0x43))
//                    expect(binary[2]).to(equal(0x44))
//                    expect(binary[3]).to(equal(0x02))
//                }
//            }
//
//            // MARK: - RangeReplaceableCollection
//            context("RangeReplaceableCollection") {
//                it("Should initialize with empty Data") {
//                    let binary = Binary()
//
//                    expect(binary.count).to(equal(0))
//                }
//
//                it("Should replace subrange using a collection") {
//                    var binary: Binary = [0x01, 0x02, 0x03]
//
//                    binary.replaceSubrange(0..<2, with: [0xFF, 0x00])
//
//                    print(binary.toByteArray())
//
//                    expect(binary[0]).to(equal(0xFF))
//                    expect(binary[1]).to(equal(0x00))
//                    expect(binary[2]).to(equal(0x03))
//                }
//
//                it("Should replace subrange using a collection bigger than the range") {
//                    var binary: Binary = [0x01, 0x02, 0x03]
//
//                    binary.replaceSubrange(0..<2, with: [30, 09, 19, 92])
//
//                    print(binary.toByteArray())
//
//                    expect(binary[0]).to(equal(30))
//                    expect(binary[1]).to(equal(09))
//                    expect(binary[2]).to(equal(19))
//                    expect(binary[3]).to(equal(92))
//                    expect(binary[4]).to(equal(0x03))
//                }
//            }
//
//            // MARK: - Little Endian Tests
//            context("Bit access - Little Endian") {
//                it("Get the correct bits for 0000001") {
//                    do {
//                        let binary: Binary = [0b0000001]
//                        let bit0 = try binary.bit(0)
//                        let bit1 = try binary.bit(1)
//                        let bit2 = try binary.bit(2)
//                        let bit3 = try binary.bit(3)
//                        let bit4 = try binary.bit(4)
//                        let bit5 = try binary.bit(5)
//                        let bit6 = try binary.bit(6)
//                        let bit7 = try binary.bit(7)
//
//                        // Asserts
//                        expect(bit0).to(equal(1))
//                        expect(bit1).to(equal(0))
//                        expect(bit2).to(equal(0))
//                        expect(bit3).to(equal(0))
//                        expect(bit4).to(equal(0))
//                        expect(bit5).to(equal(0))
//                        expect(bit6).to(equal(0))
//                        expect(bit7).to(equal(0))
//                    } catch {
//                        fail("It should get the correct bit values")
//                    }
//                }
//
//                it("Get the correct bits for 11111110") {
//                    do {
//                        let binary: Binary = [0b11111110]
//                        let bit0 = try binary.bit(0)
//                        let bit1 = try binary.bit(1)
//                        let bit2 = try binary.bit(2)
//                        let bit3 = try binary.bit(3)
//                        let bit4 = try binary.bit(4)
//                        let bit5 = try binary.bit(5)
//                        let bit6 = try binary.bit(6)
//                        let bit7 = try binary.bit(7)
//
//                        // Asserts
//                        expect(bit0).to(equal(0))
//                        expect(bit1).to(equal(1))
//                        expect(bit2).to(equal(1))
//                        expect(bit3).to(equal(1))
//                        expect(bit4).to(equal(1))
//                        expect(bit5).to(equal(1))
//                        expect(bit6).to(equal(1))
//                        expect(bit7).to(equal(1))
//                    } catch {
//                        fail("It should get the correct bit values")
//                    }
//                }
//
//                it("Get the correct bits for 11110000111") {
//                    do {
//                        let binary: Binary = [0b00000101, 0b10000111]
//                        let bit0 = try binary.bit(0)
//                        let bit1 = try binary.bit(1)
//                        let bit2 = try binary.bit(2)
//                        let bit3 = try binary.bit(3)
//                        let bit4 = try binary.bit(4)
//                        let bit5 = try binary.bit(5)
//                        let bit6 = try binary.bit(6)
//                        let bit7 = try binary.bit(7)
//                        let bit8 = try binary.bit(8)
//                        let bit9 = try binary.bit(9)
//                        let bit10 = try binary.bit(10)
//                        let bit11 = try binary.bit(11)
//                        let bit12 = try binary.bit(12)
//                        let bit13 = try binary.bit(13)
//                        let bit14 = try binary.bit(14)
//                        let bit15 = try binary.bit(15)
//
//                        // Asserts
//                        expect(bit0).to(equal(1))
//                        expect(bit1).to(equal(1))
//                        expect(bit2).to(equal(1))
//                        expect(bit3).to(equal(0))
//                        expect(bit4).to(equal(0))
//                        expect(bit5).to(equal(0))
//                        expect(bit6).to(equal(0))
//                        expect(bit7).to(equal(1))
//                        expect(bit8).to(equal(1))
//                        expect(bit9).to(equal(0))
//                        expect(bit10).to(equal(1))
//                        expect(bit11).to(equal(0))
//                        expect(bit12).to(equal(0))
//                        expect(bit13).to(equal(0))
//                        expect(bit14).to(equal(0))
//                        expect(bit15).to(equal(0))
//                    } catch {
//                        fail("It should get the correct bit values")
//                    }
//                }
//
//                it("Get the correct bits for 00010110000111") {
//                    do {
//                        let binary: Binary = [0b000101, 0b10000111]
//                        let bit0 = try binary.bit(0)
//                        let bit1 = try binary.bit(1)
//                        let bit2 = try binary.bit(2)
//                        let bit3 = try binary.bit(3)
//                        let bit4 = try binary.bit(4)
//                        let bit5 = try binary.bit(5)
//                        let bit6 = try binary.bit(6)
//                        let bit7 = try binary.bit(7)
//                        let bit8 = try binary.bit(8)
//                        let bit9 = try binary.bit(9)
//                        let bit10 = try binary.bit(10)
//                        let bit11 = try binary.bit(11)
//                        let bit12 = try binary.bit(12)
//                        let bit13 = try binary.bit(13)
//                        let bit14 = try binary.bit(14)
//                        let bit15 = try binary.bit(15)
//
//                        // Asserts
//                        expect(bit0).to(equal(1))
//                        expect(bit1).to(equal(1))
//                        expect(bit2).to(equal(1))
//                        expect(bit3).to(equal(0))
//                        expect(bit4).to(equal(0))
//                        expect(bit5).to(equal(0))
//                        expect(bit6).to(equal(0))
//                        expect(bit7).to(equal(1))
//                        expect(bit8).to(equal(1))
//                        expect(bit9).to(equal(0))
//                        expect(bit10).to(equal(1))
//                        expect(bit11).to(equal(0))
//                        expect(bit12).to(equal(0))
//                        expect(bit13).to(equal(0))
//                        expect(bit14).to(equal(0))
//                        expect(bit15).to(equal(0))
//                    } catch {
//                        fail("It should get the correct bit values")
//                    }
//                }
//
//                it("Get the correct bits for 00000101 00000011") {
//                    do {
//                        let binary: Binary = [0b101, 0b11]
//                        let bit0 = try binary.bit(0)
//                        let bit1 = try binary.bit(1)
//                        let bit2 = try binary.bit(2)
//                        let bit3 = try binary.bit(3)
//                        let bit4 = try binary.bit(4)
//                        let bit5 = try binary.bit(5)
//                        let bit6 = try binary.bit(6)
//                        let bit7 = try binary.bit(7)
//                        let bit8 = try binary.bit(8)
//                        let bit9 = try binary.bit(9)
//                        let bit10 = try binary.bit(10)
//                        let bit11 = try binary.bit(11)
//                        let bit12 = try binary.bit(12)
//                        let bit13 = try binary.bit(13)
//                        let bit14 = try binary.bit(14)
//                        let bit15 = try binary.bit(15)
//
//                        // Asserts
//                        expect(bit0).to(equal(1))
//                        expect(bit1).to(equal(1))
//                        expect(bit2).to(equal(0))
//                        expect(bit3).to(equal(0))
//                        expect(bit4).to(equal(0))
//                        expect(bit5).to(equal(0))
//                        expect(bit6).to(equal(0))
//                        expect(bit7).to(equal(0))
//                        expect(bit8).to(equal(1))
//                        expect(bit9).to(equal(0))
//                        expect(bit10).to(equal(1))
//                        expect(bit11).to(equal(0))
//                        expect(bit12).to(equal(0))
//                        expect(bit13).to(equal(0))
//                        expect(bit14).to(equal(0))
//                        expect(bit15).to(equal(0))
//                    } catch {
//                        fail("It should get the correct bit values")
//                    }
//                }
//
//                // MARK: - Big Endian tests
//                context("Bit access - Big Endian") {
//                    it("Get the correct bits for 0000001") {
//                        do {
//                            let binary: Binary = [0b0000001]
//                            let bit0 = try binary.bit(0, isLittleEndian: false)
//                            let bit1 = try binary.bit(1, isLittleEndian: false)
//                            let bit2 = try binary.bit(2, isLittleEndian: false)
//                            let bit3 = try binary.bit(3, isLittleEndian: false)
//                            let bit4 = try binary.bit(4, isLittleEndian: false)
//                            let bit5 = try binary.bit(5, isLittleEndian: false)
//                            let bit6 = try binary.bit(6, isLittleEndian: false)
//                            let bit7 = try binary.bit(7, isLittleEndian: false)
//
//                            // Asserts
//                            expect(bit0).to(equal(0))
//                            expect(bit1).to(equal(0))
//                            expect(bit2).to(equal(0))
//                            expect(bit3).to(equal(0))
//                            expect(bit4).to(equal(0))
//                            expect(bit5).to(equal(0))
//                            expect(bit6).to(equal(0))
//                            expect(bit7).to(equal(1))
//                        } catch {
//                            fail("It should get the correct bit values")
//                        }
//                    }
//
//                    it("Get the correct bits for 11111110") {
//                        do {
//                            let binary: Binary = [0b11111110]
//                            let bit0 = try binary.bit(0, isLittleEndian: false)
//                            let bit1 = try binary.bit(1, isLittleEndian: false)
//                            let bit2 = try binary.bit(2, isLittleEndian: false)
//                            let bit3 = try binary.bit(3, isLittleEndian: false)
//                            let bit4 = try binary.bit(4, isLittleEndian: false)
//                            let bit5 = try binary.bit(5, isLittleEndian: false)
//                            let bit6 = try binary.bit(6, isLittleEndian: false)
//                            let bit7 = try binary.bit(7, isLittleEndian: false)
//
//                            // Asserts
//                            expect(bit0).to(equal(1))
//                            expect(bit1).to(equal(1))
//                            expect(bit2).to(equal(1))
//                            expect(bit3).to(equal(1))
//                            expect(bit4).to(equal(1))
//                            expect(bit5).to(equal(1))
//                            expect(bit6).to(equal(1))
//                            expect(bit7).to(equal(0))
//                        } catch {
//                            fail("It should get the correct bit values")
//                        }
//                    }
//
//                    it("Get the correct bits for 11110000111") {
//                        do {
//                            let binary: Binary = [0b00000101, 0b10000111]
//                            let bit0 = try binary.bit(0, isLittleEndian: false)
//                            let bit1 = try binary.bit(1, isLittleEndian: false)
//                            let bit2 = try binary.bit(2, isLittleEndian: false)
//                            let bit3 = try binary.bit(3, isLittleEndian: false)
//                            let bit4 = try binary.bit(4, isLittleEndian: false)
//                            let bit5 = try binary.bit(5, isLittleEndian: false)
//                            let bit6 = try binary.bit(6, isLittleEndian: false)
//                            let bit7 = try binary.bit(7, isLittleEndian: false)
//                            let bit8 = try binary.bit(8, isLittleEndian: false)
//                            let bit9 = try binary.bit(9, isLittleEndian: false)
//                            let bit10 = try binary.bit(10, isLittleEndian: false)
//                            let bit11 = try binary.bit(11, isLittleEndian: false)
//                            let bit12 = try binary.bit(12, isLittleEndian: false)
//                            let bit13 = try binary.bit(13, isLittleEndian: false)
//                            let bit14 = try binary.bit(14, isLittleEndian: false)
//                            let bit15 = try binary.bit(15, isLittleEndian: false)
//
//                            // Asserts
//                            expect(bit0).to(equal(0))
//                            expect(bit1).to(equal(0))
//                            expect(bit2).to(equal(0))
//                            expect(bit3).to(equal(0))
//                            expect(bit4).to(equal(0))
//                            expect(bit5).to(equal(1))
//                            expect(bit6).to(equal(0))
//                            expect(bit7).to(equal(1))
//                            expect(bit8).to(equal(1))
//                            expect(bit9).to(equal(0))
//                            expect(bit10).to(equal(0))
//                            expect(bit11).to(equal(0))
//                            expect(bit12).to(equal(0))
//                            expect(bit13).to(equal(1))
//                            expect(bit14).to(equal(1))
//                            expect(bit15).to(equal(1))
//                        } catch {
//                            fail("It should get the correct bit values")
//                        }
//                    }
//
//                    it("Get the correct bits for 00010110000111") {
//                        do {
//                            let binary: Binary = [0b000101, 0b10000111]
//                            let bit0 = try binary.bit(0, isLittleEndian: false)
//                            let bit1 = try binary.bit(1, isLittleEndian: false)
//                            let bit2 = try binary.bit(2, isLittleEndian: false)
//                            let bit3 = try binary.bit(3, isLittleEndian: false)
//                            let bit4 = try binary.bit(4, isLittleEndian: false)
//                            let bit5 = try binary.bit(5, isLittleEndian: false)
//                            let bit6 = try binary.bit(6, isLittleEndian: false)
//                            let bit7 = try binary.bit(7, isLittleEndian: false)
//                            let bit8 = try binary.bit(8, isLittleEndian: false)
//                            let bit9 = try binary.bit(9, isLittleEndian: false)
//                            let bit10 = try binary.bit(10, isLittleEndian: false)
//                            let bit11 = try binary.bit(11, isLittleEndian: false)
//                            let bit12 = try binary.bit(12, isLittleEndian: false)
//                            let bit13 = try binary.bit(13, isLittleEndian: false)
//                            let bit14 = try binary.bit(14, isLittleEndian: false)
//                            let bit15 = try binary.bit(15, isLittleEndian: false)
//
//                            // Asserts
//                            expect(bit0).to(equal(0))
//                            expect(bit1).to(equal(0))
//                            expect(bit2).to(equal(0))
//                            expect(bit3).to(equal(0))
//                            expect(bit4).to(equal(0))
//                            expect(bit5).to(equal(1))
//                            expect(bit6).to(equal(0))
//                            expect(bit7).to(equal(1))
//                            expect(bit8).to(equal(1))
//                            expect(bit9).to(equal(0))
//                            expect(bit10).to(equal(0))
//                            expect(bit11).to(equal(0))
//                            expect(bit12).to(equal(0))
//                            expect(bit13).to(equal(1))
//                            expect(bit14).to(equal(1))
//                            expect(bit15).to(equal(1))
//                        } catch {
//                            fail("It should get the correct bit values")
//                        }
//                    }
//
//                    it("Get the correct bits for 0b101 0b11") {
//                        do {
//                            let binary: Binary = [0b101, 0b11]
//                            let bit0 = try binary.bit(0, isLittleEndian: false)
//                            let bit1 = try binary.bit(1, isLittleEndian: false)
//                            let bit2 = try binary.bit(2, isLittleEndian: false)
//                            let bit3 = try binary.bit(3, isLittleEndian: false)
//                            let bit4 = try binary.bit(4, isLittleEndian: false)
//                            let bit5 = try binary.bit(5, isLittleEndian: false)
//                            let bit6 = try binary.bit(6, isLittleEndian: false)
//                            let bit7 = try binary.bit(7, isLittleEndian: false)
//                            let bit8 = try binary.bit(8, isLittleEndian: false)
//                            let bit9 = try binary.bit(9, isLittleEndian: false)
//                            let bit10 = try binary.bit(10, isLittleEndian: false)
//                            let bit11 = try binary.bit(11, isLittleEndian: false)
//                            let bit12 = try binary.bit(12, isLittleEndian: false)
//                            let bit13 = try binary.bit(13, isLittleEndian: false)
//                            let bit14 = try binary.bit(14, isLittleEndian: false)
//                            let bit15 = try binary.bit(15, isLittleEndian: false)
//
//                            // Asserts
//                            expect(bit0).to(equal(0))
//                            expect(bit1).to(equal(0))
//                            expect(bit2).to(equal(0))
//                            expect(bit3).to(equal(0))
//                            expect(bit4).to(equal(0))
//                            expect(bit5).to(equal(1))
//                            expect(bit6).to(equal(0))
//                            expect(bit7).to(equal(1))
//                            expect(bit8).to(equal(0))
//                            expect(bit9).to(equal(0))
//                            expect(bit10).to(equal(0))
//                            expect(bit11).to(equal(0))
//                            expect(bit12).to(equal(0))
//                            expect(bit13).to(equal(0))
//                            expect(bit14).to(equal(1))
//                            expect(bit15).to(equal(1))
//                        } catch {
//                            fail("It should get the correct bit values")
//                        }
//                    }
//                }
//
//            }
//
//            // MARK: - Nibble parsing
//            context("Nibble parsing") {
//                it("Should get the correct nibbles for 0x0F") {
//                    let binary: Binary = [0x0F]
//                    do {
//                        let nibble0 = try binary.nibble(0)
//                        let nibble1 = try binary.nibble(1)
//
//                        expect(nibble0).to(equal(0))
//                        expect(nibble1).to(equal(15))
//                    } catch {
//                        fail("It failed to get nibbles.")
//                    }
//                }
//
//                it("Should get the correct nibbles for 0xF0CA") {
//                    guard let binary = Binary(with: "F0CA") else {
//                        fail("Failed to initialize binary with F0CA")
//                        return
//                    }
//
//                    do {
//                        let nibble0 = try binary.nibble(0)
//                        let nibble1 = try binary.nibble(1)
//                        let nibble2 = try binary.nibble(2)
//                        let nibble3 = try binary.nibble(3)
//
//                        expect(nibble0).to(equal(15))
//                        expect(nibble1).to(equal(0))
//                        expect(nibble2).to(equal(12))
//                        expect(nibble3).to(equal(10))
//                    } catch {
//                        fail("It failed to get the nibbles of 0xF0CA")
//                    }
//                }
//
//                it("Should get the correct value for [0x0, 0xCA]") {
//                    let binary: Binary = [0x0, 0xCA]
//
//                    do {
//                        let nibble0 = try binary.nibble(0)
//                        let nibble1 = try binary.nibble(1)
//                        let nibble2 = try binary.nibble(2)
//                        let nibble3 = try binary.nibble(3)
//
//                        expect(nibble0).to(equal(0))
//                        expect(nibble1).to(equal(0))
//                        expect(nibble2).to(equal(12))
//                        expect(nibble3).to(equal(10))
//                    } catch {
//                        fail("it failed to get the nibbles from [0x0, 0xCA]")
//                    }
//                }
//
//                it("Should get the correct value for 0x0CA") {
//                    guard let binary = Binary(with: "0CA") else {
//                        fail("Failed to initialize binary with '0CA'")
//                        return
//                    }
//
//                    do {
//                        let nibble0 = try binary.nibble(0)
//                        let nibble1 = try binary.nibble(1)
//                        let nibble2 = try binary.nibble(2)
//                        let nibble3 = try binary.nibble(3)
//
//                        expect(nibble0).to(equal(0))
//                        expect(nibble1).to(equal(0))
//                        expect(nibble2).to(equal(12))
//                        expect(nibble3).to(equal(10))
//                    } catch {
//                        fail("it failed to get the nibbles from '0CA'")
//                    }
//                }
//
//                it("Should get the correct value for [0xA, 0xB]") {
//                    let binary: Binary = [0xA, 0xB]
//
//                    do {
//                        let nibble0 = try binary.nibble(0)
//                        let nibble1 = try binary.nibble(1)
//                        let nibble2 = try binary.nibble(2)
//                        let nibble3 = try binary.nibble(3)
//
//                        expect(nibble0).to(equal(0))
//                        expect(nibble1).to(equal(10))
//                        expect(nibble2).to(equal(0))
//                        expect(nibble3).to(equal(11))
//                    } catch {
//                        fail("it failed to get the nibbles from [0xA, 0xB]")
//                    }
//                }
//            }
//
//            // MARK: - Integer parsing
//            context("Integer Parsing") {
//
//                // MARK: Unsigned Integers
//                it("Should parse UInt8 with length") {
//                    do {
//                        let binary: Binary = [0xFF]
//                        let parsedInt: UInt8 = try binary.scanValue(start: 0, length: 1)
//                        expect(parsedInt).to(equal(UInt8.max)) // UInt8.max => 255
//                    } catch {
//                        fail("It should have parsed UInt8, but it failed.")
//                    }
//                }
//
//                it("Should parse UInt8") {
//                    let binary: Binary = [0xFF]
//                    do {
//                        let parsedInt: UInt8 = try binary.get(at: 0)
//                        expect(parsedInt).to(equal(UInt8.max)) // UInt8.max => 255
//                    } catch {
//                        fail("It should have parsed UInt8, but it failed.")
//                    }
//                }
//
//                it("Should parse UInt16 with length") {
//                    let binary: Binary = [0xFF, 0xFF]
//                    do {
//                        let parsedInt: UInt16 = try binary.scanValue(start: 0, length: 2)
//                        expect(parsedInt).to(equal(UInt16.max)) // UInt16.max => 65535
//                    } catch {
//                        fail("It should have parsed UInt16, but it failed.")
//                    }
//                }
//
//                it("Should parse UInt16") {
//                    let binary: Binary = [0xFF, 0xFF]
//                    do {
//                        let parsedInt: UInt16 = try binary.get(at: 0)
//                        expect(parsedInt).to(equal(UInt16.max)) // UInt16.max => 65535
//                    } catch {
//                        fail("It should have parsed UInt16, but it failed.")
//                    }
//                }
//
//                it("Should parse UInt32 with length") {
//                    let binary: Binary = [0xFF, 0xFF, 0xFF, 0xFF]
//                    do {
//                        let parsedInt: UInt32 = try binary.scanValue(start: 0, length: 4)
//                        expect(parsedInt).to(equal(UInt32.max)) // UInt32.max => 4294967295
//                    } catch {
//                        fail("It should have parsed UInt32, but it failed.")
//                    }
//                }
//
//                it("Should parse UInt32") {
//                    let binary: Binary = [0xFF, 0xFF, 0xFF, 0xFF]
//                    do {
//                        let parsedInt: UInt32 = try binary.get(at: 0)
//                        expect(parsedInt).to(equal(UInt32.max)) // UInt32.max => 4294967295
//                    } catch {
//                        fail("It should have parsed UInt32, but it failed.")
//                    }
//                }
//
//                it("Should parse UInt64 with length") {
//                    let binary: Binary = [0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF]
//                    do {
//                        let parsedInt: UInt32 = try binary.scanValue(start: 0, length: 8)
//                        expect(parsedInt).to(equal(UInt32.max)) // UInt64.max => 18446744073709551615
//                    } catch {
//                        fail("It should have parsed UInt64, but it failed.")
//                    }
//                }
//
//                it("Should parse UInt64") {
//                    let binary: Binary = [0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF]
//                    do {
//                        let parsedInt: UInt64 = try binary.get(at: 0)
//                        expect(parsedInt).to(equal(UInt64.max)) // UInt64.max => 18446744073709551615
//                    } catch {
//                        fail("It should have parsed UInt64, but it failed.")
//                    }
//                }
//
//                // MARK: Signed Integers
//                // TODO: Add test for remaining Integer types.
//                it("Should parse Int") {
//
//                }
//
//            }
//
//            // MARK: FloatingPoint numbers
//            context("FloatingPoint Numbers Parsing") {
//                it("Should parse Double with length") {
//                    let doubleBin: Binary = [0x71, 0x3d, 0x0a, 0xd7, 0xa3, 0x10, 0x45, 0x40] // => 42.13
//                    do {
//                        let parsedDouble: Double = try doubleBin.scanValue(start: 0, length: 8)
//                        expect(parsedDouble).to(equal(42.13))
//                    } catch {
//                        fail("It should have parsed Double, but it failed.")
//                    }
//                }
//
//                it("Should parse Double") {
//                    let doubleBin: Binary = [0x71, 0x3d, 0x0a, 0xd7, 0xa3, 0x10, 0x45, 0x40] // => 42.13
//                    do {
//                        let parsedDouble: Double = try doubleBin.get(at: 0)
//                        expect(parsedDouble).to(equal(42.13))
//                    } catch {
//                        fail("It should have parsed Double, but it failed.")
//                    }
//                }
//
//                it("Should parse Float with length") {
//                    let floatBin: Binary = [0x1F, 0x85, 0x28, 0x42] // => 42.13
//                    do {
//                        let parsedDouble: Float = try floatBin.scanValue(start: 0, length: 4)
//                        expect(parsedDouble).to(equal(42.13))
//                    } catch {
//                        fail("It should have parsed Float, but it failed.")
//                    }
//                }
//
//                it("Should parse Float") {
//                    let floatBin: Binary = [0x1F, 0x85, 0x28, 0x42] // => 42.13
//                    do {
//                        let parsedDouble: Float = try floatBin.get(at: 0)
//                        expect(parsedDouble).to(equal(42.13))
//                    } catch {
//                        fail("It should have parsed Float, but it failed.")
//                    }
//                }
//            }
//
//            // MARK: - Strings
//            context("String Parsing") {
//                let binString1: Binary = [0x43, 0x61, 0x79, 0x6E, 0x61, 0x6E, 0x00] // => "Caynan"
//                let binString2: Binary = [0x48, 0x6F, 0x72, 0x75, 0x73] // => "Horus"
//
//                it("Should parse string with given length") {
//                    do {
//                        let parsedString = try binString2.get(offset: 0, length: 5)
//                        expect(parsedString).to(equal("Horus"))
//                    } catch {
//                        fail("It should have parsed String with offset, but it failed")
//                    }
//                }
//
//                it("Should parse Nul terminated string") {
//                    do {
//                        let parsedString = try binString1.get(offset: 0)
//                        expect(parsedString).to(equal("Caynan"))
//                    } catch {
//                        fail("It should have parsed nul terminated string, but it failed")
//                    }
//                }
//            }
//
//            // MARK: - CustomStringConvertible
//            context("CustomStringConvertible Implementation") {
//                let bin: Binary = [0, 1, 127, 128, 255]
//                it("Should return hex represenation of `bin`") {
//                    expect(String(describing: bin)).to(equal("00017f80ff"))
//                }
//            }
//        }
//
//
//
//    }
//
//}

