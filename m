Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7878BCD98F6
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 15:56:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C341C4027F;
	Thu, 18 Jun 2026 17:56:12 +0200 (CEST)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by mails.dpdk.org (Postfix) with ESMTP id EF3B240268
 for <dev@dpdk.org>; Thu, 18 Jun 2026 17:56:11 +0200 (CEST)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-13721dfd471so1753495c88.1
 for <dev@dpdk.org>; Thu, 18 Jun 2026 08:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781798171;
 x=1782402971; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P6Cvf9dYg3jgZ6bMSQ8ZzwbCNqjTjVCzUiMksQZQt3Y=;
 b=E2n0DzJdSuxurGPCMPoFQ+FiEgW8oG4JGXBeKxUDd1Apw0dFH/JAI6B4oNdhoVeWUZ
 XaP7V3PgdA5vkOo8p58KLR0zuyGaENuaTFPgYRcx3v+3a/DjobX6jfiaGR4ylkaxqbat
 oRItVQu2CQbzSejRov5db3enAnhw30GE/YvrMletI1QyfmBGtAr2SPpHtGTEigI6FmE3
 mEv673oHO76gA2jvDrhv0oVV4hGmtEKylhqhdG90nybPzT+r+PiEUpiGomPhJKcnOKZP
 XTx1wkS9PxcXkwg8BcEPLzOtEY72UvhID8FLHxy6V94Fih2uGvFlGn8XqtKXlMfqTKUQ
 2scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781798171; x=1782402971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P6Cvf9dYg3jgZ6bMSQ8ZzwbCNqjTjVCzUiMksQZQt3Y=;
 b=OeTMzrp6kH7lvc1dS6HFkdFzlpu3qnbgXBxaqEYtWNr4FJ0w164gbYO2SlK/q/kRgN
 h0NF3M3fzwUdjGECTS4X4X3WlK8pVt0T3ISRkFccQgWOpPGx/lVfaXwrDna9q1NKTCf5
 ej23Yr7nZJp8GhAUfbrUha3W3IITPdW1Lll8af0qWPtLdr1lOPX9mU9mXuxOVzkkDefQ
 BEoiG/wl6ZmAV2WfpBYiaDj9y0U6spmBGYhlvJmCaPldtWGb+9MHdCAkNA7okJ9AOLBw
 ghw061+TM9LJ6pEYxE6Fv08G3oscqIeN6g2vLY2B8HMNnjBtkrdQsBlBnHNk5afwmfzk
 iLNQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/eG+2I07fLyfIyAklVvJwZ1mgRCHN1IXzLbNmRP9ExkX+9NKyAG6mt/WQ1kdZj+qWnL2U=@dpdk.org
X-Gm-Message-State: AOJu0YzO9U0eWLJCR7GhV+iqXUSx902yFLrHH68+r85F7jNL6RvUWEh1
 PXyVLgTwtfdOMnoNmwaMEFRjYVF7bu88cFgxLoB/J/fqcamJmrRY7BB2SZ53FWac5O4=
X-Gm-Gg: AfdE7cnSTnN25kzh+feVBI8RJTWJnFj3Rt9cBYLZzC02FqXAlycG7o5uvUgEL+/qRZ3
 PK8jb9abQ+YunsSDMr6DHpBLI3AlqdCgtxQ3RoUqmAwPCTAOiEMKiwwvnln5B2VMTZO9R7Bzels
 /L/JEOen215Fz1H9ooAO4DQiu1JPQC0BLrgKzCEDmp/b/kAyKAOJj5GVFQfV/b81UNBoXNAsWiH
 cxmPsC2OqknOiSnxyw2jvYrw6vbUhYsCjvkZVXOgksJadopPUNiKh24ORPYdA2nHd2V/FwVsFm3
 3uS4Vlz0xwqQgBlAWOQw6ATB9CSNo+wNZ3ExNHAoKekAG0kzRh1C/nKdT+ri3+yo+TFE+/aPlDx
 BnF3WYK+aiWYNjulWYGdYQxN9pSxPdd2DV4ONFnLzNj1yEupwSlhqxlw/9951WiKCSgnWOH5YwG
 w+fMC5hH49J7JgKJVqmn2JAjaj48gg0NMyh+iH0HF/UOxKce6aCy2G9w==
X-Received: by 2002:a05:7022:e23:b0:138:12fa:377e with SMTP id
 a92af1059eb24-139a210e309mr138920c88.20.1781798170760; 
 Thu, 18 Jun 2026 08:56:10 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c02b17238sm355529eec.9.2026.06.18.08.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 08:56:10 -0700 (PDT)
Date: Thu, 18 Jun 2026 08:56:06 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: david.marchand@redhat.com, dev@dpdk.org
Subject: Re: [PATCH v1 00/17] net/dpaa: bug fixes for bus, net and fmlib
 drivers
Message-ID: <20260618085606.46b295ba@phoenix.local>
In-Reply-To: <20260618141151.3990283-1-hemant.agrawal@nxp.com>
References: <20260618141151.3990283-1-hemant.agrawal@nxp.com>
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

On Thu, 18 Jun 2026 19:41:34 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> This series contains bug fixes for the DPAA PMD (bus/dpaa, net/dpaa,
> net/dpaa/fmlib and dma/dpaa):
> 
> - Fix error handling in qman_create_fq and qman_query
> - Fix fqid endianness in qman_fq_flow_control
> - Fix CGR index usage in dpaa_modify_cgr
> - Add null check in fmlib scheme delete
> - Fix BMI RX stats register offset
> - Fix file descriptor leak after CCSR mmap
> - Fix device probe regression on LS1043A
> - Fix double-close in device remove path
> - Fix incorrect condition in interrupt unregister
> - Fix Coverity-reported issues in dpaa_flow and dpaa_qdma
> - Fix xstat name for tx undersized counter
> - Fix xstat string typos in BMI stats table
> - Remove duplicate ptype entries
> - Fix wrong buffer in xstats get by id
> - Fix null l3_len check in checksum offload
> - Fix mbuf leak in SG fd creation
> 
> All patches are bug fixes tagged with Fixes: and Cc: stable@dpdk.org.
> 
> Gagandeep Singh (3):
>   bus/dpaa: fix device probe issue
>   net/dpaa: fix device remove
>   net/dpaa: fix invalid check on interrupt unregister
> 
> Hemant Agrawal (11):
>   bus/dpaa: fix error handling of qman_create_fq
>   bus/dpaa: fix fqid endianness
>   bus/dpaa: fix error handling in qman_query
>   net/dpaa: fix modify cgr to use index
>   bus/dpaa: fix fd leak for ccsr mmap
>   net/dpaa: fix xstat name for tx undersized counter
>   net/dpaa: fix xstat string typos in BMI stats table
>   net/dpaa: remove duplicate ptype entries
>   net/dpaa: fix wrong buffer in xstats get by id
>   net/dpaa: fix null l3_len check in checksum offload
>   net/dpaa: fix mbuf leak in SG fd creation
> 
> Jun Yang (1):
>   bus/dpaa: fix BMI RX stats register offset
> 
> Prashant Gupta (1):
>   net/dpaa/fmlib: add null check in scheme delete
> 
> Vanshika Shukla (1):
>   net/dpaa: fix coverity reported issues
> 
>  drivers/bus/dpaa/base/qbman/bman_driver.c |  3 ++-
>  drivers/bus/dpaa/base/qbman/qman.c        | 11 +++++----
>  drivers/bus/dpaa/base/qbman/qman_driver.c |  6 ++---
>  drivers/bus/dpaa/dpaa_bus.c               |  6 ++---
>  drivers/bus/dpaa/include/fman.h           |  6 ++---
>  drivers/dma/dpaa/dpaa_qdma.c              |  7 +++++-
>  drivers/net/dpaa/dpaa_ethdev.c            | 27 +++++++++++------------
>  drivers/net/dpaa/dpaa_flow.c              |  4 ++++
>  drivers/net/dpaa/dpaa_rxtx.c              |  3 +++
>  drivers/net/dpaa/fmlib/fm_lib.c           |  3 +++
>  10 files changed, 46 insertions(+), 30 deletions(-)
> 

Looks good but there are some warnings from more detailed AI review that
need addressing.

Review of [PATCH v1 00/17] bus/dpaa, net/dpaa fixes

Reviewed against current main. No errors found; the series is a
solid set of bug fixes. A few warnings and notes below, mostly
about undocumented side effects and Fixes: accuracy. Patches not
listed (01, 02, 03, 04, 06, 07, 12, 14, 15, 16, 17) look correct.


[PATCH v1 05/17] net/dpaa/fmlib: add null check in scheme delete

Info: the commit body refers to FM_PCD_MatchTableSchemeDelete(),
but the function actually changed is fm_pcd_kg_scheme_delete().
The NULL guard and E_NO_DEVICE return are correct and match the
sibling functions in fm_lib.c; only the message names the wrong
API.


[PATCH v1 08/17] bus/dpaa: fix device probe issue

The early "return 0" was indeed skipping device-list creation, so
removing it fixes probe on LS1043A. Good.

Warning: that early return did two things -- it forced
max_push_rxq_num = 0 AND skipped the DPAA_PUSH_QUEUES_NUMBER
override that follows. With the return gone, execution now falls
through to:

	penv = getenv("DPAA_PUSH_QUEUES_NUMBER");
	if (penv)
		dpaa_bus.max_push_rxq_num = atoi(penv);

so on LS1043A the env var can now raise the push-queue count back
above zero, which the original code deliberately prevented (the
comment is "Disabling the default push mode for LS1043A", and the
SoC has the FMAN push-mode errata handled in dpaa_rxtx.c). If
LS1043A must keep push mode disabled regardless of the env var,
guard the override, e.g.:

	if (dpaa_bus.svr_ver == SVR_LS1043A_FAMILY) {
		dpaa_bus.max_push_rxq_num = 0;
	} else {
		penv = getenv("DPAA_PUSH_QUEUES_NUMBER");
		...
	}

If the override is intended to apply to LS1043A, please say so in
the commit message.


[PATCH v1 09/17] net/dpaa: fix device remove

The RTE_ETH_DEV_UNUSED guard against double close/release is
correct, and "int ret = 0" is now required because the assignment
is conditional.

Warning: the patch also drops the dpaa_finish() call, which the
commit message does not mention. dpaa_finish() is registered as a
destructor (RTE_FINI_PRIO(dpaa_finish, 103)), so it still runs at
process exit, but the previous explicit call ran at last-device
remove (!dpaa_valid_dev). Removing it moves the global teardown
(dpaa_fm_term, per-queue portal close, is_global_init = 0) from
last-remove time to exit time. For run-then-exit this is
equivalent, but for remove-all-then-continue (e.g. re-probe in a
running process) is_global_init now stays 1 and portals stay open
until exit. Please call this change out in the commit message and
confirm re-probe still behaves.


[PATCH v1 10/17] net/dpaa: fix invalid check on interrupt unregister

The fix is correct: rte_intr_callback_unregister() returns the
number of callbacks removed (>=1) on success and a negative value
on failure, so "if (ret)" logged a spurious warning on every
successful unregister; "if (ret < 0)" is right.

Warning: the Fixes: tag points at

	9c99878aa1 ("log: introduce logtype register macro")

which is unrelated to interrupt unregistration and looks like a
copy/paste error. An incorrect Fixes: will misdirect the stable
backport -- please point it at the commit that introduced the
"if (ret)" check.


[PATCH v1 11/17] net/dpaa: fix coverity reported issues

Both fixes are correct. The dpaa_qdma.c bound (num == 0 ||
num > FSL_QDMA_SG_MAX_ENTRY) prevents the desc_ssge[num - 1]
underflow when pending_num is 0. The dpaa_flow.c port_handle
close fixes the continue-path leak without introducing a
double-close: the success path nulls port_handle inside
dpaa_fm_deconfig(), and the error/continue paths legitimately
leave it set for the new guard to close.

Info: this bundles two unrelated Coverity fixes across
drivers/dma/dpaa and drivers/net/dpaa under a single net/dpaa
Fixes: tag (e7665de896). The qdma OOB almost certainly has a
different origin commit. Splitting into two patches (or at least
carrying the correct Fixes: for the qdma change) would make the
stable backport cleaner.


[PATCH v1 13/17] net/dpaa: fix xstat string typos in BMI stats table

Both typo fixes are correct.

Info: the very next entry on the same table is also misspelled --
"rx_buf_diallocate" (fmbm_rbdc, "Rx Buffers Deallocate Counter")
should be "rx_buf_deallocate". Worth fixing in the same pass since
this patch is specifically cleaning up these names.
