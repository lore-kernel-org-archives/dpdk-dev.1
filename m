Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61BDD6CFAA
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 00:23:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 713CA402AF;
	Fri, 23 Jan 2026 01:23:20 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 8FF76400D5
 for <dev@dpdk.org>; Fri, 23 Jan 2026 01:23:18 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so22518255e9.0
 for <dev@dpdk.org>; Thu, 22 Jan 2026 16:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769127798;
 x=1769732598; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CEp1gNp2HaEEr6sSgQe3oQGQOK5tYuItvxD930vaM3I=;
 b=DXOyGg7JC4nxSA4ZYUi9RAg3X0yOjCsmLzxO3Xela61RzaikkucuL2KkDHcwJJDXi+
 5GpBc9mvvZSLaUuwcPUe9sF7L2As8ER1okcQvardHQPwUtMVHY9S3MVZeZ4+Bk6Zb2rO
 Dtn8mOLjJYhKMoC4+ot/Hr4flTRoptaiWydf3vUSmK87fGffcPIq9WSOlwX5fcomtCOt
 i0fK/BGklTrgSDaBa8RJjYu3ha7lhNqrVrKvRtw1ayVBIMEdLZSk6r1z8OVD93oxFCs0
 EEAVuJtlmQctETDPIy7wc259QuFAjH5g1KmGsLbNPirIWJO1nBngHV2ZOEUgPc/fwQXk
 SwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769127798; x=1769732598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CEp1gNp2HaEEr6sSgQe3oQGQOK5tYuItvxD930vaM3I=;
 b=NHdkKMvGYspeYQha86QBsJnDRHaGjF3r2a4c0N2a+OBRVMGPbz7q0BloizWOQSAEIq
 AAhrLhmnALXlhDJxsXw7yXpn8VVmVAUSpPbGn3SXqWKdFsNMjBW73w5QUsKUCC9In3wk
 RsqE5WadRfTjaI55G6ldmz3UdajRMdNcJ+ssNaYR9mp4PG9srKuzCiqB85R6EDLN6RVf
 MU4dmIFD1V7o29gPSbTL/633PpAJ7ziv0BhtVrqN9lXGnLvJ0U+bgQBiV2YBjOmLhbNu
 2jJJ1bcsrY4iJNV2y7bmVIcuRT4vUe+KnNZMgnWhrdxHGj4GcFbImhsj7y2zpbSx1dxw
 stmg==
X-Gm-Message-State: AOJu0Yz9eKaV0PEggr6PJYAZw9M5tC6Z+wIyL+cGugCJJDJG0T0Yg101
 TVYYpmIEUryNNlhhbYA83kBER/+1liId1QreUn8AfChDrnRp60fXDeXJ5PwnwSSSGYs=
X-Gm-Gg: AZuq6aI1lZzDSdKH0plh1gH4h1X9a7AlbnH7efPLtZ6k8eCzJEl+I73D2sN8clXDaYA
 Wz2TLgCHlLiemA9xf8HRpSl+asH0Qj7osM1nF/Tb3qLrWQMQQO/BxDExMF05XWeB5osBBKslL/a
 18/DWAHRtf9+bPhxXOAsTgRH690d5+U7O60G0JaWGZr/oaBeDtPMj/XocZHc9Y61NtivJYvvTi3
 +8tw025U5u5C7IKNZLCou0/VzM1IMQspXm8nbDGbPaAdUsinWSO7YEIPDEYVn/N0L2Dg5NxQ7qp
 3R589qp8DfixjdKr1SR305pNIgEoJMhUATc8ca2VPhSdgem1XaMQd+Cc4Kvdxwyr9o8XSL6zHj2
 qUJKaAEeIRmEXZN6trNK291wzQQbFmBGjGD4Rom8cteC4yHjYGHxVh4BCAwvF347ms35GucmyZR
 nZ4FYBjrK3UZafcX5g+VmDkW22AQAEjPfhP2Yo1No3rWdr8fkfkqsh
X-Received: by 2002:a05:600c:5298:b0:47e:e57d:404 with SMTP id
 5b1f17b1804b1-4804c96513cmr23412425e9.16.1769127797609; 
 Thu, 22 Jan 2026 16:23:17 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d8a5b67sm14394975e9.10.2026.01.22.16.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 16:23:16 -0800 (PST)
Date: Thu, 22 Jan 2026 16:23:10 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Radu Nicolau <radu.nicolau@intel.com>
Cc: dev@dpdk.org, nkaithakadan@marvell.com, kai.ji@intel.com,
 anoobj@marvell.com, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>
Subject: Re: [PATCH v5 1/2] cryptodev: add support for 256-NxA4/5/6 algorithms
Message-ID: <20260122162310.5a1e1320@phoenix.local>
In-Reply-To: <20260122102606.2531599-1-radu.nicolau@intel.com>
References: <20260107105649.1708347-1-radu.nicolau@intel.com>
 <20260122102606.2531599-1-radu.nicolau@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

On Thu, 22 Jan 2026 10:25:33 +0000
Radu Nicolau <radu.nicolau@intel.com> wrote:

> Add support for
>=20
> NEA4, NIA4, NCA4: Snow 5G confidentiality, integrity and AEAD modes
> NEA5, NIA5, NCA5: AES 256 confidentiality, integrity and AEAD modes
> NEA6, NIA6, NCA6: ZUC 256 confidentiality, integrity and AEAD modes
>=20
> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>

Working on AI based patch review and used this pair as a test case.
The results showed some things (mostly documentation) that could be
fixed and also some false positives like recommending adding __rte_experime=
ntal
to enum.

=3D=3D=3D Patch Review: bundle-1674-crypto-v5.mbox (via Claude) =3D=3D=3D
# DPDK Patch Review - bundle-1674-crypto-v5.mbox

## Summary
This patch series adds support for 256-bit NxA4/5/6 algorithms (SNOW 5G, AE=
S-256, and ZUC-256 confidentiality, integrity, and AEAD modes) to the DPDK =
cryptodev library.

---

## ERROR Level Issues

### 1. Missing Release Notes Update
**Location:** Entire patchset =20
**Issue:** No updates to release notes in `doc/guides/rel_notes/` =20
**Guideline Violation:** Documentation requirements - "Update release notes=
 in `doc/guides/rel_notes/` for important changes"

**Required Action:**
```
Must add a release notes entry for the current release documenting:
- New cipher algorithms: RTE_CRYPTO_CIPHER_SNOW5G_NEA4, RTE_CRYPTO_CIPHER_A=
ES_NEA5, RTE_CRYPTO_CIPHER_ZUC_NEA6
- New auth algorithms: RTE_CRYPTO_AUTH_SNOW5G_NIA4, RTE_CRYPTO_AUTH_AES_NIA=
5, RTE_CRYPTO_AUTH_ZUC_NIA6
- New AEAD algorithms: RTE_CRYPTO_AEAD_SNOW5G_NCA4, RTE_CRYPTO_AEAD_AES_NCA=
5, RTE_CRYPTO_AEAD_ZUC_NCA6
```

### 2. Missing `__rte_experimental` Tags
**Location:** `lib/cryptodev/rte_crypto_sym.h` =20
**Issue:** New enum values added to public API without experimental marking=
 =20
**Guideline Violation:** "New APIs must be marked as `__rte_experimental`"

**Details:**
- Lines 185-188 (cipher algorithms)
- Lines 394-402 (auth algorithms) =20
- Lines 504-509 (AEAD algorithms)

**Required Action:**
While enum values typically don't receive `__rte_experimental` directly, th=
e lack of any experimental marking or API versioning for this significant f=
eature addition is concerning. Consider:
1. Adding a deprecation notice period
2. Or documenting the API stability commitment in release notes

### 3. Commit Message Body Length Violations
**Location:** Patch 1/2 commit message =20
**Issue:** Body is only 3 lines but doesn't meet guideline expectations =20
**Guideline Violation:** Body should provide context and justification

**Required Content:**
```
Should include:
- Why these algorithms are being added
- Standards/specifications being implemented
- Use case description
```

---

## WARNING Level Issues

### 1. Subject Line Style Issues
**Location:** Both patches =20
**Issue:** Subject lines are good but could be more descriptive

**Current:**
```
[PATCH v5 1/2] cryptodev: add support for 256-NxA4/5/6 algorithms
[PATCH v5 2/2] test/crypto: add tests for 256-NxA4/5/6 algorithms
```

**Recommendation:**
```
cryptodev: add SNOW 5G/AES-256/ZUC-256 NEA/NIA/NCA support
test/crypto: add tests for SNOW 5G/AES-256/ZUC-256 NEA/NIA/NCA
```

### 2. Inconsistent Algorithm Naming in Documentation
**Location:** Patch 1, `lib/cryptodev/rte_crypto_sym.h` =20
**Issue:** Comments use inconsistent naming conventions

**Examples:**
- Line 186: `/**< Snow 5G algorithm in NEA4 mode */`
- Line 508: `/**< ZUC-256 algorithm in NCA6 mode */`

**Recommendation:**
Be consistent with hyphenation and capitalization:
- "SNOW 5G" or "Snow 5G" (not "Snow 5G" mixed with "SNOW5G")
- "ZUC-256" or "ZUC 256" consistently

### 3. Missing API Documentation
**Location:** Patch 1, `lib/cryptodev/rte_crypto_sym.h` =20
**Issue:** Minimal documentation for new enum values

**Required:**
Add detailed Doxygen comments explaining:
- Algorithm specifications/standards
- Key size requirements (256-bit)
- IV/nonce size requirements (16 bytes)
- Expected tag sizes for AEAD modes
- Bit vs byte length semantics

### 4. Test Helper Function Error Handling
**Location:** Patch 2, `app/test/test_cryptodev.c` =20
**Issue:** Inconsistent error handling in helper functions

**Lines 19923-19987 (`test_NEA_helper`):**
```c
if (retval !=3D 0)
    return retval;
```
But then at line 19969:
```c
TEST_ASSERT_NOT_NULL(ut_params->op, "failed to retrieve obuf");
```

**Issue:** Mixing return codes with TEST_ASSERT macros. Should be consisten=
t.

**Recommendation:**
```c
if (retval !=3D 0)
    return TEST_FAILED;

TEST_ASSERT_NOT_NULL(ut_params->op, "failed to retrieve obuf");
```

### 5. Magic Number Usage
**Location:** Throughout test code =20
**Issue:** Hard-coded values without clear explanation

**Examples:**
- Line 19930: `32` (key length)
- Line 19931: `16` (IV length)
- Line 19933: `RTE_ALIGN_CEIL(tdata->msg_size, 8)` (why 8?)

**Recommendation:**
Define constants:
```c
#define NEA_KEY_LEN 32
#define NEA_IV_LEN 16
#define NEA_BLOCK_SIZE 8
```

### 6. Incomplete Test Suite Setup Error Handling
**Location:** Lines 19915-19948 (`nxan_testsuite_setup`) =20
**Issue:** `check_cipher_capabilities_supported` return values not checked =
properly

**Current:**
```c
if (check_cipher_capabilities_supported(...) !=3D 0 ||
    check_auth_capabilities_supported(...) !=3D 0 ||
    check_aead_capabilities_supported(...) !=3D 0) {
    RTE_LOG(INFO, USER1, "Capability requirements...");
    return TEST_SKIPPED;
}
```

**Issue:** Assumes all non-zero returns mean "not supported". Some return v=
alues might indicate errors.

### 7. Test Vector File Header Guard
**Location:** `test_cryptodev_nxan_test_vectors.h`, line 5 =20
**Issue:** Header guard ends with `_H_` which is unconventional

**Current:**
```c
#ifndef TEST_CRYPTODEV_NXAN_TEST_VECTORS_H_
```

**Recommendation:**
```c
#ifndef _TEST_CRYPTODEV_NXAN_TEST_VECTORS_H
```

### 8. Potential Memory Leak in Test Helpers
**Location:** `test_NIA_helper`, `test_NEA_helper`, `test_NCA_helper` =20
**Issue:** No cleanup on error paths

**Example (line 19923-19987):**
```c
ut_params->ibuf =3D rte_pktmbuf_alloc(ts_params->mbuf_pool);
/* ... operations ... */
if (retval !=3D 0)
    return retval;  // Leaks ut_params->ibuf
```

**Required:** Add proper cleanup:
```c
if (retval !=3D 0) {
    if (ut_params->ibuf)
        rte_pktmbuf_free(ut_params->ibuf);
    return TEST_FAILED;
}
```

---

## INFO Level Issues

### 1. Test Vector Organization
**Location:** `test_cryptodev_nxan_test_vectors.h` =20
**Observation:** Very large file (2029 lines) with similar structure

**Suggestion:**
Consider generating test vectors programmatically or using a more compact f=
ormat for maintainability.

### 2. Duplicate Test Structure Code
**Location:** Lines 20370-20989 =20
**Issue:** Highly repetitive test case definitions

**Example Pattern:**
```c
static int
test_NEA4_case_1_encrypt(void)
{
    return test_NEA_helper(&nea4_test_1, RTE_CRYPTO_CIPHER_OP_ENCRYPT);
}
static int
test_NEA4_case_1_decrypt(void)
{
    return test_NEA_helper(&nea4_test_1, RTE_CRYPTO_CIPHER_OP_DECRYPT);
}
```

**Suggestion:**
Consider using a macro to reduce repetition:
```c
#define TEST_NEA_CASE(suite, num) \
    static int test_##suite##_case_##num##_encrypt(void) { \
        return test_NEA_helper(&suite##_test_##num, RTE_CRYPTO_CIPHER_OP_EN=
CRYPT); \
    } \
    static int test_##suite##_case_##num##_decrypt(void) { \
        return test_NEA_helper(&suite##_test_##num, RTE_CRYPTO_CIPHER_OP_DE=
CRYPT); \
    }
```

### 3. Comment Formatting in Test Vectors
**Location:** Throughout test vector definitions =20
**Observation:** Hex data formatting could be improved for readability

**Current:**
```c
.key =3D {
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
```

**Suggestion:** Add comments indicating byte positions:
```c
.key =3D {
    /* Bytes 0-7 */
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    /* Bytes 8-15 */
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
```

### 4. Test Suite Naming Consistency
**Location:** Lines 20698-20984 =20
**Observation:** Suite names use different formats

**Examples:**
```c
.suite_name =3D "256 NEA4 (SNOW 5G) Test Suite",
.suite_name =3D "256 NEA5 (AES 256) Test Suite",
.suite_name =3D "256 NEA6 (ZUC 256) Test Suite",
```

**Suggestion:** Consider more concise names:
```c
.suite_name =3D "SNOW 5G NEA4 Test Suite",
.suite_name =3D "AES-256 NEA5 Test Suite",
.suite_name =3D "ZUC-256 NEA6 Test Suite",
```

### 5. Unused Test Data Variable
**Location:** Line 20101 (`nea6_test_9`) =20
**Observation:** `nea6_test_9` is defined but never used

```c
static const
struct nxa_256_test_data nea6_test_9 =3D {
    // ... identical to nea6_test_7 ...
};
```

**Action:** Either remove or add to test suite.

### 6. Missing Error Message Details
**Location:** Various `TEST_ASSERT_*` calls =20
**Issue:** Generic error messages

**Example (line 19969):**
```c
TEST_ASSERT_NOT_NULL(ut_params->op, "failed to retrieve obuf");
```

**Suggestion:**
```c
TEST_ASSERT_NOT_NULL(ut_params->op,=20
    "Failed to process crypto operation for %s",=20
    tdata->test_name);
```

### 7. Code Style: Line Length
**Location:** Multiple locations =20
**Observation:** Some lines approach or exceed 100 characters

**Example (line 19933):**
```c
retval =3D create_wireless_algo_cipher_operation(tdata->iv,
            16, RTE_ALIGN_CEIL(tdata->msg_size, 8), 0);
```

**Within limits but could be clearer with:**
```c
uint32_t aligned_msg_size =3D RTE_ALIGN_CEIL(tdata->msg_size, 8);
retval =3D create_wireless_algo_cipher_operation(tdata->iv, 16,
                                                aligned_msg_size, 0);
```

---

## COMPLIANCE SUMMARY

### =E2=9C=85 Correct

1. **License Headers:** All new files have proper SPDX license identifiers
2. **Copyright:** Intel copyright notices present and properly formatted
3. **C Style:** Code follows DPDK style guidelines (indentation, braces, na=
ming)
4. **Commit Format:** Signed-off-by present, reasonable subject line length
5. **Test Infrastructure:** Proper use of `unit_test_suite_runner` framework
6. **Code Patterns:** No forbidden tokens, no unnecessary casts

### =E2=9D=8C Must Fix (Errors)

1. Missing release notes update
2. Missing API stability documentation
3. Insufficient commit message detail

### =E2=9A=A0=EF=B8=8F Should Fix (Warnings)

1. Inconsistent algorithm naming
2. Incomplete API documentation
3. Test helper error handling issues
4. Missing cleanup on error paths
5. Magic numbers without constants
6. Memory leak potential in tests

### =F0=9F=92=A1 Consider (Info)

1. Reducing code repetition with macros
2. Improving test vector organization
3. Adding more descriptive error messages
4. Using constants for magic numbers

---

## RECOMMENDATION

**Status:** CHANGES REQUESTED

The patch implements the core functionality correctly and follows most DPDK=
 conventions. However, it requires:

1. **Mandatory:** Add release notes entry
2. **Mandatory:** Expand commit message with context
3. **Strongly Recommended:** Fix memory leak potential in test helpers
4. **Recommended:** Add comprehensive API documentation
