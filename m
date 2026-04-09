Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14907F31E43
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 15:42:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AFBF4028D;
	Thu,  9 Apr 2026 17:42:55 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id 707AC40276
 for <dev@dpdk.org>; Thu,  9 Apr 2026 17:42:53 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-82c70e4654eso520017b3a.2
 for <dev@dpdk.org>; Thu, 09 Apr 2026 08:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775749372;
 x=1776354172; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kX49oQx1s/cX3QeYdyHYkWebNeknXgzH2lOkuQepbOM=;
 b=ZhSt36Ya89mR5h0tlDLqdapxoy3iJF2JBD1f6rCxU6OOVcGFelnomcR6jZuO6IArTX
 vYFL/7B9pthNAAWzDXD1CGVSJzY0S+7tDcoGcEOy/an82LWQJfH0U1X6P1BTS5G05Pge
 YXBq4Ba0bkA6n6nSdiZAFvvsva9Og09DZAGlB8gfUPMT1yfYf7st4Gmd1RJuw8Ajg8xc
 0QQo/d9QZ6r6p7w4N38QN+fP78dxP1GY7/YFXn7ooX4jYCM/fmoDv4wPqIRavg71w3Y7
 8VE2uXXB7qrhv7q2fViAJ8YKpyyS+EUHykt7QibK115Bzs9VQvqrSYVqZFqm8nqsExyg
 GMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775749372; x=1776354172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kX49oQx1s/cX3QeYdyHYkWebNeknXgzH2lOkuQepbOM=;
 b=oI+6s9UibBb08aiRysP+2xqjHzzvkABexLPpImye6JaYS9rhvqlXPhXDMKkiUMaSIm
 QRY8ovU5pVeAkyJ+r1dYz6216EiNUnI1544QXvQ4XfKcgVINKPI/Xat2o9qSnefrgLoi
 piOy9v9ancFXIOsdUuud58QUToGm6hmRZkz1dvfO+wxRLig/EKtPhaFOiJ5kEu47X2q/
 TZe8X+9iR/gY2FSdlS9kAFtW901pAt+T/WDZDxS7MP9gEOCnS2O7fWBNNLkfidsmyeTY
 lJ7hJ6MrrKwhgAEDLsCddpDjdJ/5kRTdFeFHipd1x8heWx5HtGsejVVuk75XtvZqxWnr
 ebqg==
X-Gm-Message-State: AOJu0YyUJmMV2XCZzAcJSKQtn7aMgPcNuwu4UmYyc9OEvrkcJMZM4W/r
 hg5Mt3fEzQkQkNxEn2Fy+EOCIeYihpJtbGBfxYgP4YLxeiQXI3eUxXHB81wwR8tmo5Q=
X-Gm-Gg: AeBDietrgtAuugdkGw38yDvZOqaWqB2aXY2nQSxvvMa1nSS9t1NSCaik4ZYiNJL1VqF
 /6Zr6L/PcHSvxY6g7lTESrbK2HirQJe1TCJf2LJjGryL9gjQabsu9gOnWwnsEDfZRLZL0esnbj3
 hMvuxz4aLFdIdH9LC3K8Z21nRJ01xNXqJnTdYdqPFFbxebos4R4tCeIZXDiCiTIDM2VjzkPrWU9
 cw6QVHPBegbf+7kuqJSoUEga2I5KH6HPIHU1IR2aZPHAWGwH0oEeAZxF6SRBaaSTsZmVwaiGd5j
 e8/OjovqVmdOfo+k3WHPK0zMCrvV4CG4k07B7KuYyzFHBqm86oXzjEBxc84dzu3TTFddIQL7+Tc
 YZwI8oCj5/IZ15bC2cLt7eGiE3EKImZqEWgy9UTt7eBugD2LD1QL4f/e+ohx9XKCP8ypzmRni57
 RUKSP7p9J59SU1ZzELv8dKEC5CHhN8CLvemEYHNnNU64m6vA==
X-Received: by 2002:a05:6a00:2d18:b0:827:3e27:161f with SMTP id
 d2e1a72fcca58-82d0da454e6mr24554955b3a.2.1775749372290; 
 Thu, 09 Apr 2026 08:42:52 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b27064sm31476113b3a.9.2026.04.09.08.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 08:42:52 -0700 (PDT)
Date: Thu, 9 Apr 2026 08:42:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: DPDK ACL library Security Analysis
Message-ID: <20260409084245.409ac2d0@phoenix.local>
In-Reply-To: <2fc0e47d6fca4cf1ad203f74f09db0b7@huawei.com>
References: <20260408195746.62e3b9f8@phoenix.local>
 <2fc0e47d6fca4cf1ad203f74f09db0b7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 9 Apr 2026 15:20:50 +0000
Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:

> > | ID | Description | Severity | CVSS |
> > |----|-------------|----------|------|
> > | ACL-001 | SIMD Unbounded Transition Index | CRITICAL | 7.5 |
> > | ACL-002 | Algorithmic Complexity DoS | HIGH | 6.5 |
> > | ACL-003 | Unbounded Node Creation | HIGH | 6.5 |  
> 
> I had a look and believe all three are false positives.
> Details below.

Your right, if you want to see AI admitting that...

# DPDK ACL Library Security Analysis - Updated Report  
## Access Control List Packet Classification

**To:** ACL Library Maintainers  
**Date:** April 9, 2026  
**Re:** Response to Konstantin Ananyev's feedback  
**Library Path:** `lib/acl/`  

---

## Executive Summary

Following detailed feedback from ACL maintainer Konstantin Ananyev (Huawei), this report addresses his claims that all reported vulnerabilities are false positives. After further analysis, we maintain that the SIMD bounds checking concern requires attention, while acknowledging the existing control mechanisms for the other issues.

### Revised Assessment

| ID | Description | Status After Review | Priority |
|----|-------------|---------------------|----------|
| ACL-001 | SIMD Transition Index | **REQUIRES FURTHER INVESTIGATION** | MEDIUM |
| ACL-002 | Algorithmic Complexity | **FALSE POSITIVE** (Control Plane) | N/A |
| ACL-003 | Node Creation Limits | **FALSE POSITIVE** (NODE_MAX exists) | N/A |

---

## Response to Feedback

### ACL-001: SIMD Unbounded Transition Array Index

**Original Claim:** Critical out-of-bounds read vulnerability  
**Maintainer Response:** "Address is extracted from internal ACL tables which obviously contains only valid indexes"

**Revised Analysis:**
- **Maintainer's point acknowledged:** The transition indexes should theoretically come from pre-validated ACL trie structures
- **Security concern remains:** Defense-in-depth principle suggests bounds checking is still valuable
- **File existence corrected:** `acl_run_avx512.h` does not exist as claimed in original report

**Locations (Corrected):**
- **SSE:** `lib/acl/acl_run_sse.h:167,173,179,185`  
- **NEON:** `lib/acl/acl_run_neon.h:150-153`  
- **ALTIVEC:** `lib/acl/acl_run_altivec.h:173-177`

**Recommended Action:** 
Consider adding debug-mode bounds checking for development/testing environments rather than production performance-critical code.

```c
#ifdef RTE_ACL_DEBUG_BOUNDS
    if (unlikely(idx >= ctx->trans_table_size)) {
        RTE_LOG(WARNING, ACL, "Unexpected transition index %u\n", idx);
        /* Log but continue - may indicate trie corruption */
    }
#endif
```

### ACL-002: Algorithmic Complexity DoS

**Original Claim:** CPU exhaustion during trie merge  
**Maintainer Response:** "Building ACL trie is memory and CPU consuming process... it is unavoidable... this is control plane"

**Verdict:** **FALSE POSITIVE**
- **Acknowledged:** This is inherently a control plane operation
- **Acknowledged:** Complexity is a known tradeoff for ACL performance
- **Not a security vulnerability:** Administrative operations are expected to consume resources
- **Mitigation exists:** Applications can limit ACL rule complexity via policy

### ACL-003: Unbounded Node Creation

**Original Claim:** Memory exhaustion via unlimited node allocation  
**Maintainer Response:** Provided evidence of existing `NODE_MAX 0x4000` limit in `build_trie()` function

**Verdict:** **FALSE POSITIVE**
- **Existing protection confirmed:** `context->cur_node_max` limits nodes per trie  
- **Current limit:** `NODE_MAX 0x4000` (16,384 nodes)
- **Code reference provided:**
```c
node_count = context->num_nodes - node_count;
if (node_count > context->cur_node_max) {
    *last = prev;
    return trie;  // Terminates build when limit reached
}
```

---

## Lessons Learned

### 1. Insufficient Source Analysis
The original report was based on pattern matching without full understanding of existing protective mechanisms and architectural context.

### 2. Control Plane vs Data Plane Confusion  
Issues ACL-002 and ACL-003 affect rule compilation (control plane) rather than packet processing (data plane), significantly reducing their security impact.

### 3. File Verification
The claim about `acl_run_avx512.h` was not verified against actual source tree.

---

## Remaining Recommendations

### 1. Documentation Enhancement
- Document the NODE_MAX limit and its security implications
- Clarify control plane vs data plane security boundaries
- Add comments explaining SIMD index safety assumptions

### 2. Debug Infrastructure  
- Consider adding debug-mode bounds checking for SIMD paths
- Add telemetry for ACL build resource consumption

### 3. Fuzzing Enhancement
- Ensure fuzz testing covers malformed ACL rule patterns
- Test edge cases around NODE_MAX limits

---

## Acknowledgments

Thanks to Konstantin Ananyev for the detailed technical feedback and clarifications on ACL library architecture. This response demonstrates the importance of maintainer engagement in responsible disclosure processes.

---

**Files Analyzed:** 9 C files, 3 SIMD header variants (corrected count)  
**Report Version:** 2.0 (Updated)  
**Status:** 1 item requires further discussion, 2 items closed as false positives

**END OF UPDATED REPORT**
