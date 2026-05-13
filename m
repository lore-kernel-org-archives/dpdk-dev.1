Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5ACCD4851
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 May 2026 14:41:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 932DE402B6;
	Wed, 13 May 2026 16:41:21 +0200 (CEST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52]) by mails.dpdk.org (Postfix) with ESMTP id DD87640041
 for <dev@dpdk.org>; Wed, 13 May 2026 16:41:19 +0200 (CEST)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-5a88de2b52eso8834745e87.2
 for <dev@dpdk.org>; Wed, 13 May 2026 07:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778683279;
 x=1779288079; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EYHT73Yd5nUVjfw+aHt+xIkUGMWL9fRbdqJDAVBZG40=;
 b=d/aQwrPSnMHD3GnPZNwjHAzqWu+uMiGE7GOk1j4EH4rNkVVjYXmvnajLWSvjLr9dlD
 +cpSwvwXC15LTB7HxBpygMxpiH9IreQm9jroCIVGZTmDF99fDI6EMeGcyyNYjGxNsm7y
 6EScBt46nz4TotTbI/2tDta3MYWRpLfAZxnTyX8jnj7afPMHytsjA4VxOhD3Ex0Kect8
 6832uKzr3JyZK4VR9a7zRS5mfellL0wwkzNMOMS/+6aDYDtaIXyY6ixc6FRE/bPJvEVm
 E0RloDchSIBDa8NEX+a0+JmddSQsX9x2cfHmRY3X7ldoLZkQ9zLbFeX+WXbUPvACHWv6
 CcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778683279; x=1779288079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EYHT73Yd5nUVjfw+aHt+xIkUGMWL9fRbdqJDAVBZG40=;
 b=Gl4d0FGMik79conJgy3xViGgT7a+LZfy1iQwSrVBrH+wJfha7mnIYudjzaFhRApAun
 aLkn6N/cY0tpqYT9kPNE1+pykpd/GG4sdwxXh+KXVpb8ji405rxHn/Pi58YqT8QRnEA8
 gZ1FohEKw0iTnd2Q02SPepsE2RvFN6id0KBcoTyzk9OO/lIOlqLxY1vJQZNVcdSNhp7N
 r7LpVZFupqkzR3valQt/U5F7tTV8Ume9UGiqVKbCq92Z/ld1GDhu20gdXsxzTrJqsq5Z
 AoHsjalvNLEtWFTW2XyVSwHnrWxgmJGildINGW3DbjHS8IZinnsDAYUaVappnUa1KFCU
 RJ1w==
X-Gm-Message-State: AOJu0YyQ28lQBcRagsHB87mXXX1XFbp18/Tv+V5tUB9oBM4ymzJle20S
 fxdU8AKhZpN4jmfyF2ZqvKr5KQRAQxApCnplIRB0mbtM2ifoOzmw162pznATLv7A0tA=
X-Gm-Gg: Acq92OHxyI9UNALKJyKeslgkLlyXq+dKr05bG1ZcsC5sp7wxL4v6AKyqf1+Qz8MkwqX
 Ar4ZEV3rxxcKpOk/bqbfQ7yeYW7aa3Tb3QLjSVCmHw+niQBgziFh/PKyj9FPw/h5noxHK/inTdm
 JhL/DrtqDjjX8F3qpGBBrAqpFL8JVQOQ42H+ZzVoZFBaZxyt7VyBqlX7dGcGE9mqjuMRno0ZGvZ
 ibhHVRULU4T7ldqoY2JLoTiRW7kaD8RffHgGc2NOpd83jlEopGhMu2INCMuJScTTlS8Sg53yFhQ
 dgVIp3YatqUiEPvxFwcSHRthIqFsuzyjucR9/GUfDw+Y9QVTg9yDN5eHqVUQLMkruQ1PI1fSXll
 a+aPiHkl3gbheD9NAfnGvQIjf4CnfHDN0V67s87Nz6mdb8arreswp2Z0y+w5nGDaumYN4mIMKaB
 IElfLPw+XejxRqPSRsWWgFtNqpe1tBEmwctvrjPCc7
X-Received: by 2002:a05:6512:1381:b0:5a3:fd0e:ce6f with SMTP id
 2adb3069b0e04-5a8f39bead0mr1124773e87.23.1778683278810; 
 Wed, 13 May 2026 07:41:18 -0700 (PDT)
Received: from stephen-xps.local ([62.119.255.230])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8a955dfa8sm4169438e87.41.2026.05.13.07.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 07:41:17 -0700 (PDT)
Date: Wed, 13 May 2026 16:41:14 +0200
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mark Blasko <blasko@google.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/6] net/gve: add hardware timestamping support
Message-ID: <20260513164114.25de780b@stephen-xps.local>
In-Reply-To: <20260512005404.946979-1-blasko@google.com>
References: <20260512005404.946979-1-blasko@google.com>
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

On Tue, 12 May 2026 00:53:47 +0000
Mark Blasko <blasko@google.com> wrote:

> This patch series introduces support for GVE hardware timestamping on DQO
> queues. To support concurrent access, a mutex lock is introduced to protect
> admin queue operations. A mechanism is then added to periodically synchronize
> the NIC clock via AdminQ, and support is introduced for the read_clock ethdev
> operation. Finally, the RX datapath is updated to reconstruct full 64-bit
> timestamps from the 32-bit values in DQO descriptors.
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
>  doc/guides/nics/gve.rst                |  18 +++
>  doc/guides/rel_notes/release_26_07.rst |   3 +
>  drivers/net/gve/base/gve_adminq.c      | 127 +++++++++++++++++----
>  drivers/net/gve/base/gve_adminq.h      |  29 +++++
>  drivers/net/gve/base/gve_desc_dqo.h    |   8 +-
>  drivers/net/gve/gve_ethdev.c           | 148 ++++++++++++++++++++++++-
>  drivers/net/gve/gve_ethdev.h           |  39 +++++++
>  drivers/net/gve/gve_rx_dqo.c           |  26 +++++
>  10 files changed, 378 insertions(+), 22 deletions(-)
> 

Please use version when sending updated patches. See contribution docs.
I.e use -v2 --in-reply-to <mail message id>

AI review spotted some issues:

Patch 1: net/gve: add thread safety to admin queue

Info: The new adminq_lock is initialized with PTHREAD_MUTEX_ROBUST,
but pthread_mutex_lock() return values are not checked anywhere in
the patch. With robust attribute set, lock can return EOWNERDEAD if
a previous owner terminated while holding the mutex; the caller is
required to call pthread_mutex_consistent() in that case, otherwise
the mutex transitions to ENOTRECOVERABLE on subsequent locks. In a
single-process DPDK PMD a thread crash brings down the whole
process, so EOWNERDEAD is unreachable in practice and the robust
attribute is unnecessary. The existing flow_rule_lock in this
driver uses PROCESS_SHARED but not ROBUST. Drop
pthread_mutexattr_setrobust() to match.


Patch 5: net/gve: support read clock ethdev op

Warning: gve_read_clock and the periodic alarm callback
gve_read_nic_clock share a single DMA buffer (priv->nic_ts_report)
for the GVE_ADMINQ_REPORT_NIC_TIMESTAMP response. The adminq_lock
introduced in patch 1 serializes the adminq command exchange, but
is released inside gve_adminq_execute_cmd before either caller
reads the buffer:

    err = gve_adminq_report_nic_timestamp(priv,
                                priv->nic_ts_report_mz->iova);
    /* lock has already been released here */
    if (err != 0)
        return err;
    ts = be64_to_cpu(priv->nic_ts_report->nic_timestamp);

If the user thread (gve_read_clock) is preempted between returning
from gve_adminq_report_nic_timestamp and the be64_to_cpu read, the
alarm callback can run, memset() the buffer to zero, take the
adminq lock, issue its own command, and either leave its own
response in the buffer or be mid-DMA when the user thread reads.
The user thread will then read zero or a different command's
response.

The simplest fix is to return the cached
priv->last_read_nic_timestamp from gve_read_clock rather than
issuing a fresh adminq command. The periodic sync runs every
250ms, so the cached value is recent; the .read_clock semantics
do not require a brand new device read. Alternatively, use a
separate per-caller DMA buffer or extend the critical section
to cover the buffer read.


Patch 6: net/gve: reconstruct HW timestamps from DQO

Warning: RTE_ETH_RX_OFFLOAD_TIMESTAMP is added to
dev_info->rx_offload_capa whenever priv->nic_timestamp_supported
is true, but per-packet timestamp delivery is only implemented in
the DQO RX path (gve_rx_burst_dqo). For GQI devices,
rxq->timestamp_enabled is never set (gve_rx_queue_setup_dqo is
the only setup path that consults the offload flag), and the GQI
burst function does not touch the timestamp fields. A GQI user
that enables RX_OFFLOAD_TIMESTAMP will see the configure call
succeed and no timestamps appear in any mbuf - the offload is
silently a no-op.

The release notes for this series ("Added hardware timestamping
support on DQO queues") already scope the feature to DQO. The
capability advertisement should match:

    if (!gve_is_gqi(priv) && priv->nic_timestamp_supported)
        dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_TIMESTAMP;

Info: doc/guides/nics/gve.rst's new "Timestamp Offload" section
should mention that the per-packet RX timestamp requires DQO
queue format. The .read_clock op works regardless of queue
format; only the per-packet path is DQO-only.
