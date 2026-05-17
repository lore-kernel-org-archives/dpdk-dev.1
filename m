Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFC7CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Sun, 17 May 2026 23:15:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5028840264;
	Mon, 18 May 2026 01:15:51 +0200 (CEST)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by mails.dpdk.org (Postfix) with ESMTP id 43FD540261
 for <dev@dpdk.org>; Mon, 18 May 2026 01:15:50 +0200 (CEST)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-1329fc4bf77so3951121c88.1
 for <dev@dpdk.org>; Sun, 17 May 2026 16:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779059749;
 x=1779664549; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K8damRcC05CErhprCmMGar2dC3PQztkZ4nkBD2kEKpk=;
 b=GSWM4FfT2NOTSKy8uVu06bbwfeqqkaiZxmStjOQ7nihc3Rdgo2hLiLWR2uIAfH3WMe
 ftm8JO/d6gZui0PVON0yGqMouLpX1p8EUuHNb/yJYWrm9WVI/ovEo2HatB15bmde8KS7
 zo2lxQef60j4RXtyMfE4DtDUblaX/gjntVqgquwIok2ggHC+21jhMlF6CTA+gZE8eJj6
 Fxg9r1fgXVJcKxCvcsMzG46nWpo1PQvqjMRkzxv3GeGQLLl61EWRPN/EokJCuNYLgIoZ
 DrYdef8EwNBIG5sf/0mfWIOYwv24gmEvFklUMcbtpITOz8Kegaf7lZ3+ZmLoziqCpL6Z
 +pMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779059749; x=1779664549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K8damRcC05CErhprCmMGar2dC3PQztkZ4nkBD2kEKpk=;
 b=VOkRDI858WZy1cAjicFSiV57ii/pBJak7Vz6h7tJZddddpUbsWhe+8b1YLxYi2VjeJ
 EYIG9NlFQYpq2kgGs8YG/1LHH1j3lHQ2Wru1TR8NkiYVqQUQk4xi/vV/fcaEl2CJTS7H
 iyjNlyak+Wfb7w+esCnXbwcHkm09Tplt7IEU8/G7yIO67USMGXUpWgASiLPvx1/c55Qe
 /9PK0tNtwXHiNOQHk2ujCm6lIa5buygbQUY9RxZF1wQ072Hy1oo1pg9c6giRCvE0JYRc
 3XPwzP8WVR0rBD/CitarDR1jaVTAzoId+8Z7YJAn+h0GmqgPiczBfOVicuWz+oRu4pvt
 NBRQ==
X-Gm-Message-State: AOJu0Yzc4MTZzCD/NZn53bqvIHlNPSFLp+E86uaJbvUm8KMdlDhgoAbj
 uWl61JN97G3LPLEZ5f+miko3TLY9DPFqC0QRmy5uxv2LHADHE0bvo5hcyhbHKPRVm88=
X-Gm-Gg: Acq92OGXhNS4otaUH3u6A7RL9yaXmt/jmS0qgHY8AefqRZqDDwKzUcEfEra75MuU2YX
 oYmAsK0BG+GOppRWcoCjMlWu3VGgOVOgSK1YPtzeQK/2K/xEvxBzckgf0XE//BOA+1LmWgB+z0d
 n+nCpqTa4vZPPxFvEhYZR/AdJyfO45WkOyucKeMuCvigYK8ckqWUy+H39EH+vKr70HSsJS3RW3l
 4dne2K528M+CJ+pRriok9wKFQUmH4uYSFb2JooKUzcQMqv4VJxBvPQOxb/79mRKjH4lAr7KLSLn
 bwiaBTm5oUrC8CFs79cYohtozTaUOTskz0Cu4uKnXC7WHT94ume2Hyj0fX0lXRJouDdR27XlPRg
 Dt7f7TvmRmFhOSgoiAW0DSF1iZpJFDTeJlPKLAmqAFYyNTMI6BqFbH+lIRWScjTqHKs7hhd/oca
 1hUby6Es8Zcfh9mqfOpZIML+MP+HpzfOYKBzA=
X-Received: by 2002:a05:7300:4311:b0:2ed:e15:c923 with SMTP id
 5a478bee46e88-303986bc13cmr5626930eec.31.1779059748811; 
 Sun, 17 May 2026 16:15:48 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302944ffdf0sm13106455eec.8.2026.05.17.16.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 16:15:48 -0700 (PDT)
Date: Sun, 17 May 2026 16:15:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mark Blasko <blasko@google.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/6] net/gve: add hardware timestamping support
Message-ID: <20260517161545.2b33289a@phoenix.local>
In-Reply-To: <20260515231936.3296603-1-blasko@google.com>
References: <20260511224354.872997-1-blasko@google.com>
 <20260515231936.3296603-1-blasko@google.com>
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

On Fri, 15 May 2026 23:19:29 +0000
Mark Blasko <blasko@google.com> wrote:

> This patch series introduces support for GVE hardware timestamping on DQO
> queues. To support concurrent access, a mutex lock is introduced to protect
> admin queue operations. A mechanism is then added to periodically synchronize
> the NIC clock via AdminQ, and support is introduced for the read_clock ethdev
> operation. Finally, the RX datapath is updated to reconstruct full 64-bit
> timestamps from the 32-bit values in DQO descriptors.
> 
> ---
> v2:
> - Patch 1: Dropped ROBUST mutex attribute.
> - Patch 3: Added adminq timestamp counter reset to gve_adminq_alloc.
> - Patch 4:
>   - Removed redundant void* casts.
>   - Handled alarm reschedule failures by marking timestamp stale.
>   - Added transient error logging on memzone allocation failure.
> - Patch 5: Scoped read_clock ethdev operation strictly to DQO queues.
> - Patch 6:
>   - Scoped timestamp offload capability advertisement strictly to
>     DQO queues.
>   - Predicated capability advertisement directly on memzone
>     allocation.
>   - Initialized mbuf_timestamp_offset to -1.
>   - Added blank line separating release notes.
> ---
> 
> Mark Blasko (6):
>   net/gve: add thread safety to admin queue
>   net/gve: add device option support for HW timestamps
>   net/gve: add AdminQ command for NIC timestamps
>   net/gve: add periodic NIC clock synchronization
>   net/gve: support read clock ethdev op
>   net/gve: reconstruct HW timestamps from DQO
> 
>  .mailmap                               |   1 +
>  doc/guides/nics/features/gve.ini       |   1 +
>  doc/guides/nics/gve.rst                |  20 ++++
>  doc/guides/rel_notes/release_26_07.rst |   4 +
>  drivers/net/gve/base/gve_adminq.c      | 128 +++++++++++++++++----
>  drivers/net/gve/base/gve_adminq.h      |  29 +++++
>  drivers/net/gve/base/gve_desc_dqo.h    |   8 +-
>  drivers/net/gve/gve_ethdev.c           | 149 ++++++++++++++++++++++++-
>  drivers/net/gve/gve_ethdev.h           |  39 +++++++
>  drivers/net/gve/gve_rx_dqo.c           |  26 +++++
>  10 files changed, 383 insertions(+), 22 deletions(-)
> 

Looks good, once again AI followup still found some things you need to address.

Patch 5: net/gve: support read clock ethdev op

Error: gve_read_clock is defined as static but never assigned to
any eth_dev_ops table. In v1 the patch added
".read_clock = gve_read_clock" to both gve_eth_dev_ops and
gve_eth_dev_ops_dqo. The v2 changelog notes "Scoped read_clock
ethdev operation strictly to DQO queues," which should have left
the assignment in gve_eth_dev_ops_dqo and removed it from
gve_eth_dev_ops. Instead both assignments were dropped, leaving
the function unreferenced. DPDK CI builds with -Dwerror=true, so
-Wunused-function will fail the build, and the read_clock feature
is unreachable at runtime in any case.

Restore the assignment in gve_eth_dev_ops_dqo:

    static const struct eth_dev_ops gve_eth_dev_ops_dqo = {
            ...
            .reta_query           = gve_rss_reta_query,
            .read_clock           = gve_read_clock,
    };

Warning: (unchanged from v1) gve_read_clock and the periodic
gve_read_nic_clock alarm callback both issue
GVE_ADMINQ_REPORT_NIC_TIMESTAMP into the single shared DMA buffer
priv->nic_ts_report, then read it after gve_adminq_execute_cmd
has released adminq_lock. If gve_read_clock is preempted between
gve_adminq_report_nic_timestamp returning and the be64_to_cpu
read, the alarm callback can memset() and reissue its own
command, so the user thread will read either zero or another
command's response. The simplest fix is for gve_read_clock to
return the cached priv->last_read_nic_timestamp instead of
issuing a fresh adminq command - the 250ms periodic sync keeps
it fresh enough for .read_clock semantics. Once the dev_op
registration is restored this race becomes reachable.
