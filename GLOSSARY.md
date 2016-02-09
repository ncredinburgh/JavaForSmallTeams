# SUT

System under test

#  Direct inputs     

The inputs that a SUT directly receives via it's interface (i.e method parameters)

# Direct outputs    

The outputs a SUT directly returns via it's interface (i.e method return values)

# Indirect inputs   

Inputs supplied to the SUT by other components with which it interacts (i.e values supplied by DOCs)

# Indirect outputs  

Outputs of the SUT that are passed to DOCs but are not visible via the SUT interface

# Test double

Generic names for Dummy, Stub, Spy, Fake or Mock

# Dummy            

Test double that is never used or called but must be present (i.e it could just be null)

# Stub

Test double that supplies indirect inputs to SUT (and does nothing else)

# Mock              

Test double that verifies indirect outputs from SUT (may also provide indirect input)

# Spy               

Test double that captures indirect outputs from SUT to allow later verification (may also provide indirect input)

# Fake              

Test double that acts as a lightweight stand in for some other component

# Guava

An open source project from Google originally known as Google Collections. It provides common utilities for Java such as collections operations, string processing and caching. See <a href='https://github.com/google/guava/'>Guava</a>

# TDD

Test driven development or Test driven design.

