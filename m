Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675DAC624DE
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 15:02:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4903040297;
	Fri,  4 Sep 2026 17:02:27 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 616C64021F
 for <dev@dpdk.org>; Fri,  4 Sep 2026 17:02:26 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 2EB9920910;
 Fri,  4 Sep 2026 17:02:26 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: FW: |SUCCESS| [v4] eal/x86: fix memcpy alignment mask definition
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Fri, 4 Sep 2026 17:02:24 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65A33@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: |SUCCESS| [v4] eal/x86: fix memcpy alignment mask definition
Thread-Index: Ad08eN4Sp043pKHXQYa78J7tm0XE+AABQFjw
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
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

The simple AI in our CI managed - for the first time ever - to not emit =
any garbage at all, when reviewing one of my patches!

Maybe I should stick to simple patches that don't really change =
anything; then it doesn't get confused. ;-)


Venlig hilsen / Kind regards,
-Morten Br=F8rup


-----Original Message-----
From: dpdklab@iol.unh.edu [mailto:dpdklab@iol.unh.edu]=20
Sent: Friday, 4 September 2026 16.23
To: test-report@dpdk.org
Cc: Morten Br=F8rup
Subject: |SUCCESS| [v4] eal/x86: fix memcpy alignment mask definition

Test-Label: ai-code-review
Test-Status: SUCCESS
https://dpdk.org/patch/169097

_AI Code Review_

=3D=3D=3D Patch Review: series.patch (via Claude) =3D=3D=3D
Review date: 2026-09-04

# DPDK Patch Review

## Patch Summary
The patch addresses a potential symbol name collision by prefixing =
`ALIGNMENT_MASK` with `RTE_MEMCPY_`, moves function documentation, and =
fixes a coding style issue with implicit comparison.

---

## Errors

None.

---

## Warnings

None.

---

## Info

### 1. Documentation placement improvement

The patch moves the Doxygen comment from the forward declaration =
(removed at line 32) to the actual function definition (line 661). This =
improves source code browser results and follows good practice of =
documenting at the definition rather than the declaration when a =
function is static inline in a header.

**Observation:** This is a positive change. The forward declaration was =
unnecessary for a static inline function in a header file.

### 2. Symbol naming fix

The patch renames `ALIGNMENT_MASK` to `RTE_MEMCPY_ALIGNMENT_MASK` at =
lines 175, 321, 432, 709, and 715. This prevents potential name =
collisions since the macro is defined in an installed header file.

**Observation:** This correctly follows the guideline that all external =
symbols must have `RTE_` or `rte_` prefix. While `ALIGNMENT_MASK` is =
`#undef`'d at the end of the file, it is still exposed during inclusion =
and could collide with user code that defines the same name before =
including this header.

### 3. Coding style fix

The patch changes line 709 from:
```c
if (!(((uintptr_t)dst | (uintptr_t)src) & ALIGNMENT_MASK))
```
to:
```c
if ((((uintptr_t)dst | (uintptr_t)src) & RTE_MEMCPY_ALIGNMENT_MASK) =
=3D=3D 0)
```

**Observation:** This correctly changes an implicit truthiness test to =
an explicit comparison against 0, following DPDK coding style which =
requires explicit comparisons for integer values.

---

## Summary

The patch is correct and improves code quality in three ways:
1. Prevents potential symbol name collisions by adding proper `RTE_` =
prefix
2. Improves documentation discoverability by placing Doxygen comments at =
the definition
3. Conforms to DPDK coding style for explicit comparisons

No issues found. The patch follows DPDK guidelines and makes beneficial =
improvements to the codebase.
