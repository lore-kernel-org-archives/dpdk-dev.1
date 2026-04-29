Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012DDFF887E
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 15:57:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 231BB402EE;
	Wed, 29 Apr 2026 17:57:52 +0200 (CEST)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com
 [209.85.161.41]) by mails.dpdk.org (Postfix) with ESMTP id 9D056400EF
 for <dev@dpdk.org>; Wed, 29 Apr 2026 17:57:50 +0200 (CEST)
Received: by mail-oo1-f41.google.com with SMTP id
 006d021491bc7-67c22b05346so6674213eaf.2
 for <dev@dpdk.org>; Wed, 29 Apr 2026 08:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777478270;
 x=1778083070; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kPgHni3Ad3k2TIhNdbhjCZCmxKkVPWzjDUmLGga7QKM=;
 b=b1pO6Dvyo3fjjhb6lCq6h01FA3DOT9ZBgqYwIqsDTRMr3gU8yVXyPtuK8iQ1ukRPYK
 KdWpy937t6ToGm/+/g5iuDVAcDp603rm4rPJRVOZbjeIYz+G+bUte9WgCz7JRB+2WUrJ
 C9C2T0Cqw0cCVpP6FDCNi+aOWzBuM16oWDh6jUviJiTIr99R2zCbD0lCWHJiSYiUJIqr
 RKHPFH7XfIBr8L7bfc4ruVBlTdRc7YnvsTbAo1lC6FpmaeH2hZopC8u4LDKtSTDSOaeO
 VBRKjbdnDGK0xPZbOfVtqI4MqVWERczHH6i7oXggNV3tqfsawnXd5PPdSGBG0bCgRssW
 HOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777478270; x=1778083070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kPgHni3Ad3k2TIhNdbhjCZCmxKkVPWzjDUmLGga7QKM=;
 b=qCDHdz+4/3BT0Q3kpw5d4M5HUYGD7jLWPtMiB3DEVaYqQuAVNhtyvRONmNZAjdIWPE
 s7CqhFFS9H02vw7DlB6gp3v90DYA0ff5Sv+pgQtTB5V0etlhgac37xmL102zYGMQ+kR5
 R1oLt7C/qgMLPz9LSjzIXimJzW0i3S9KuEMrY3Kbp8Mts1cEPGaUhyZoPgUavlANinYv
 pNQPWRpN2V86vTmYQGVemRS12htLpXhF1T8+azdAmgUUfCryonY7+/u4UUsLJVQxdul9
 hEFwBtIa1JYLOp9FuMljzYdc5LPBD6VZXxKqpfkvqaViSA8bqzBhaG1pRDPwoLyw6aRz
 gy/A==
X-Gm-Message-State: AOJu0YxUE2blEVAZaQLEUXOuAPbqPfERbxYzlpP3/XGW0iiTi7xRExnJ
 KMkTYT/PIFFIr3YZ0BQtejyKVRdrMMNsCtTGD3wr2HpF3HYxYtBZG4864ihPb2QZb/g=
X-Gm-Gg: AeBDieslW0i3fGZc8devtPIzT2i07nt7E5xoIVdrXMJi1/Sz+SAJfBMy74E70Md6Qa1
 JtRj8NXQh5zeOOZoDv98gRPIxO8aC8j3c0IaUU/5oDmiT1tYpzIf3OnGkPLe2Gu7JC64R68HIxH
 Obh2CoEmKXdrOFYi7y6qz85lV4Xm2l8my9ouvmCO5i6iLAOxrn1F8kUfopwc0wI1fGD9AZGulTU
 8s4F9zZJ7bmvkquq+VS4HK3x/ZGjIjJjVPKiDICq62yBSQslB+6m/L0N3LDdSEqIDyPSHOiv5B0
 edcghTbJcAcDtwjWuvGAXVQ5grkYeFXNIvcowzkGNCrpoCwDD+wNIRTquOi7zrhm/i3qH7i7m6g
 i3syAQW0bnrGqZgGCo86BGfgiLvL+qGZQ8knfkoj1Qy8ccCROrXvBuL0bDGZBPtDJobyrtdA2P2
 LpnxA3MttBtIpXdqENIib9/2nlalCdHBykq1ON/dypDmgYgg==
X-Received: by 2002:a05:6820:222a:b0:695:aea7:8c1a with SMTP id
 006d021491bc7-6965cbd997cmr4205357eaf.54.1777478269396; 
 Wed, 29 Apr 2026 08:57:49 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6966bbc28fdsm1375832eaf.4.2026.04.29.08.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 08:57:49 -0700 (PDT)
Date: Wed, 29 Apr 2026 08:57:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: <dev@dpdk.org>, <wathsala.vithanage@arm.com>
Subject: Re: [PATCH v4 0/2] few improvemnts for SORING lib
Message-ID: <20260429085746.24bfcc3e@phoenix.local>
In-Reply-To: <20260423091625.123642-1-konstantin.ananyev@huawei.com>
References: <20260417212358.212692-1-konstantin.ananyev@huawei.com>
 <20260423091625.123642-1-konstantin.ananyev@huawei.com>
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

On Thu, 23 Apr 2026 10:16:23 +0100
Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:

> v3 -> v4
> - Remove too aggressive optimization (patch #1)
> - Fix AI review comments
> 
> v2 -> v3
> - fix MSVC complaints
> 
> v1 -> v2
> - fix formal API comments (doxygen complaints)
> - add section to release notes
> 
> First patch aims to improve enqueue/dequeue performance, specially
> for the cases with multiple workers lcores per stage.
> Second one introduces 'Peek API' similar to what we have for
> conventional rte_ring. Also it adds new test-cases for this new API.
> 
> Konstantin Ananyev (2):
>   ring: make soring to always finalize its own stage
>   ring: introduce peek API for soring
> 
>  app/test/meson.build                   |   1 +
>  app/test/test_soring_mt_stress.c       |  74 +++++++
>  app/test/test_soring_peek_stress.c     |  75 +++++++
>  app/test/test_soring_stress.c          |   3 +
>  app/test/test_soring_stress.h          |   1 +
>  app/test/test_soring_stress_impl.h     |  87 +-------
>  doc/guides/rel_notes/release_26_07.rst |   8 +
>  lib/ring/rte_soring.h                  | 267 ++++++++++++++++++++++++
>  lib/ring/soring.c                      | 272 ++++++++++++++++++++++---
>  9 files changed, 680 insertions(+), 108 deletions(-)
>  create mode 100644 app/test/test_soring_peek_stress.c
> 

I don't use soring, but looks good to me.

One related observation, is that would be good if soring tests used unit_test_runner
instead of having its own sub test call chain open coded.


AI had some feedback.

Series looks good overall. One issue on patch 2/2:
The doc comments for rte_soring_enqueue_bulk_start() and rte_soring_enqueue_burst_start() in lib/ring/rte_soring.h say:
User has to call appropriate enqueue_elem_finish() to copy objects
into the queue and complete given enqueue operation.
There is no rte_soring_enqueue_elem_finish(). The text was copy-pasted from rte_ring_peek.h, which uses an elem naming convention that soring does not follow. soring's actual finish functions are rte_soring_enqueue_finish() (objects only) and rte_soring_enqueux_finish() (objects plus meta). Please update the references.
The dequeue start docs are fine - they reference dequeue_finish(), which does exist.
Minor nits (optional):

__dequeue_elems() has a double space in its parameter list:
"void *objs,  void *meta"
rte_soring_dequeue_finish() uses 'num' in the header but 'n' in the implementation.
test_soring_peek_stress.c always pairs start with finish, so it doesn't exercise the peek-specific use cases (inspect-then-abandon, partial finish). Not a blocker; coverage of those could come later.

