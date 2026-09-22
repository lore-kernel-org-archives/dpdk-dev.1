Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53AAC982E6
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 00:36:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91EBE402B6;
	Tue, 22 Sep 2026 02:36:42 +0200 (CEST)
Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com
 [74.125.227.170])
 by mails.dpdk.org (Postfix) with ESMTP id AB0AE402B0
 for <dev@dpdk.org>; Tue, 22 Sep 2026 02:36:41 +0200 (CEST)
Received: by mail-pj2-f42.google.com with SMTP id
 98e67ed59e1d1-39b350c69b4so3122570a91.2
 for <dev@dpdk.org>; Mon, 21 Sep 2026 17:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790037400;
 x=1790642200; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PlhSxomtV+pknIOaCNLDkLqN+VLxQLyJoriCyrjPWuA=;
 b=qtSgErAX2IBT1ZdRxuqtP4gM2vHn3FHvVBPoyQSKGPzwBXvYi8rG4/rzcZSWEhEuX4
 V8S6YK68/R8w0hZPpKX93xLOFYQVu03J6w5z7FzskkDfhyft+vuD+SU87ouhX9gihvOH
 nz7hynrrvSjVpRXwNP0l0/oD3uXjDTjCGgs8B+1xM6AuLGcc9b+ByND5PdEp/puzigew
 L58KsTlx9f/cPZzQPQbGBHFn1FFXNBULq0sdXLQq3jOuH/oADUjOZfRXn/gNMDZX1SSa
 hcFAwVmV2WYm2mtzB0L1NfiU99xCy0eHP8qpHVk9MKRzBD/Zb+r7IGoN+OjMzAk0JQs5
 Msqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790037400; x=1790642200;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PlhSxomtV+pknIOaCNLDkLqN+VLxQLyJoriCyrjPWuA=;
 b=OcjN/A1fr95zv9tWE5kOFxaudnNSMNGhjonIGvzDUUpMNSUXKsEjwhJ+DSL3k1ABLD
 OXQC0t8mMPQhx2zPM8EculnTEaX3Qpg1Za3mn6DXLLcrHRt783OKzAr6iJMJ7nX7h8q8
 KsEOettUSDPkL5znIELModW1zRgsmZLfFWrYpqiW0213cYRETmLlcTrIyPWPJjel/qsc
 LkZkkos/oYiLwzRt/dSGz7lLXd8wlzTHFWMQ41FwvGFeKCRgnJHN4Ul5ROhltCy+a2JO
 USHlnS1V4IGtJgFtdooIyGugv+bzvo08VtRFIPObglLq+/LAn/1UTKDUOqOeh8VWgg0B
 VM8g==
X-Gm-Message-State: AFuF++m5lLgPLlO7n/6trF8aNqRpf0Dn+4VioCsViHmUxhALP9QtBPZJ
 UKUwFgHn8naPEltM5u9jM6WdanNq1DDWluyPxVAvkAntxfdebveIFSIzvzNa0vx5hN8=
X-Gm-Gg: AYBFou1YA036djVR+Uh9HsCEVw7SaqX+My9NmajBVsmGSJ6OvijxZUAIbt0hxB3IkFk
 VRdISMFK4vNWn/N8Dyv8zx2HqILbyUzgOhOYWabwugKyU+J0X+rffYIjtALYLoF5ca5bqdTH7LL
 DYnUAu03N0QI8PbgV9o+QVGLo/u92Z6z+H+inmHZfoSbwyGAEc97gh4ViwQfJy1aSRtp9uQs2G7
 ariJt97dLscegX3zzjprAVNxQXqG7Hkp9NCQNShTQMezKRSGCsS5kr0MfgGSu/IYLkt/IIGiIW/
 JEjr+izMuu9k4FTxJwgdEHTqHhtoFUoxJjGTzRfUvVrdP9V51igd3zZ0UuA2qpeDCAijqLEq1Vw
 4CfqRxPigiTdXHip7oS0SnrLpiQz5WK1pvjFhLIDc2r7CU69LtLNuwIvBIJ6Dj937TsnFnMxexh
 8XxV1C2PnF/2L4F2W0V8qXYenUdBPgI2lEG6uQ6GW/aiXjQ7oGX2oTSstphUbnm/Yy4Gw1HGdOR
 1lBdPqbci9jC3d8rv/yFgrILa3SYUihBA4nvf3X
X-Received: by 2002:a17:90a:d64f:b0:39e:4c80:44b9 with SMTP id
 98e67ed59e1d1-39e54dccbb8mr19047830a91.28.1790037400572; 
 Mon, 21 Sep 2026 17:36:40 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a06e5751f2sm143093a91.9.2026.09.21.17.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 17:36:40 -0700 (PDT)
Date: Mon, 21 Sep 2026 17:36:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 00/14] Introduce RTE_DIV_ROUND_UP
Message-ID: <20260921173638.0e3cbea5@phoenix.local>
In-Reply-To: <20260813172241.964736-1-joshwash@google.com>
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260813172241.964736-1-joshwash@google.com>
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

On Thu, 13 Aug 2026 10:22:25 -0700
Joshua Washington <joshwash@google.com> wrote:

> Numerous drivers independently define the DIV_ROUND_UP macro, using the
> same definition. Attempt to commonize by introducing RTE_DIV_ROUND_UP to
> rte_common.h and replacing usages of DIV_ROUND_UP with RTE_DIV_ROUND_UP.


Looks ok, predates use of AI review, so ran it manually.

The biggest issue reported is tat changing base/ code here
is problematic. You can do it a base/ wrapper header but
not directly at call sites.

Tested: applies cleanly to main, builds with -Werror on x86/gcc for all
touched drivers, and no DIV_ROUND_UP users remain.

Patch 1:

    Needs a test in app/test/test_common.c (exact, remainder, n=0, d=1).
    Needs a release notes entry.
    Doxygen should document the params and the caveats: d evaluated twice,
    unsigned only, and n + d - 1 can wrap (RTE_DIV_ROUND_UP(UINT32_MAX, 2)
    on uint32_t is 0). Consider ((n) / (d) + ((n) % (d) != 0)) instead.
    DIV_CEIL in app/test/test_compressdev.c and
    app/test-compress-perf/comp_perf_test_common.c could be converted too.

Base code (qede, cxgbe, ena):
Please don't edit call sites under base/. That code is synced from
vendor trees (ena-com is shared with Linux and FreeBSD) and this will
conflict on the next update. Do what i40e/ice/idpf did: keep
#define DIV_ROUND_UP(n, d) RTE_DIV_ROUND_UP(n, d)
in the osdep/platform header and leave base/ alone.

Minor:

    qede, nfp: drop the rewraps; the original lines fit in 100 columns.
    hinic: the "X must be nonnegative" comment is lost; move it to the
    rte_common.h doxygen.
    ena: leaves a double blank line in ena_plat_dpdk.h.
    13/14: subject should be "net/nfp:", not "drivers:".

The osdep-only patches (i40e, idpf, ice, hns3, bnx2x, ifpga, procinfo)
look fine.
