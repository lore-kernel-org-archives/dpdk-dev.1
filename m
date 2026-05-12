Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB27BCD4F26
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 07:14:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4BB540264;
	Tue, 12 May 2026 09:14:27 +0200 (CEST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52]) by mails.dpdk.org (Postfix) with ESMTP id 234AD400D7
 for <dev@dpdk.org>; Tue, 12 May 2026 09:14:26 +0200 (CEST)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-5a877510541so5396588e87.2
 for <dev@dpdk.org>; Tue, 12 May 2026 00:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778570065;
 x=1779174865; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=szCa8Gxas+q2Z6Tj/qY+RB/07cB/o7UcnkSmn2pUq6c=;
 b=M0smtUdpZuM4T69zYwItI7COqfVW0TTJKpNpSbdfRfGwYw3X/E4EWRviEJr6NZpmB1
 Mk7fZE1nFr5uLZkQ2DKzLYb0bR9f6DzgBiJ6z2D31P0PkHKNVPfgEJAfupg0ujxc5mhF
 QqH7LfyTrDZJC5lwue7mRIYkBimbwDyRsnOm58Sfi/m/VwDw1XebfHBZKBaZ8qeTCxef
 xpiLO8qO5D1squtsaoChcNgcw9XYWVTUz/7KP5SZIFFgeOudyQ4XA89S1GI1aG/Ywqxw
 JRI6WNlagxaXkIdUOjbcXSUalAtUdKtdB47Y9S/fbFw9TPM7y3GJOY921aexbg93ZkSy
 //5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778570065; x=1779174865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=szCa8Gxas+q2Z6Tj/qY+RB/07cB/o7UcnkSmn2pUq6c=;
 b=kj4IItHbW3lygkTXDzB0fYHryc9zxckqHieL/9MvfpGqmfjoC9bBIeODyDhmFo4BWT
 J7wnJirDubUXIUV8rxDgdxTV1fbm37gWEJCo5xUeRMHZ2H7d/9nOvKzTcTWWv6VoKbRi
 nJUq4dD0MinkYMJEwwWDK26zxc4Go4YFpJ61TdyDGbYJv3N62g0G7oju5K0RkO31gDvl
 LzxWuyOWeMfRJXMbUxEpIlbjPLbi3PLHF8EwCF75nUEb6hGJ/76DjLOj4l40xxYCcW2P
 Y6PnCdFZWzRjF3Itx5GjhqCxckLDuA3KRFKuewmLC4fSPrF16EeQpi1qHowTWpfBxm+o
 gaZw==
X-Gm-Message-State: AOJu0YynxcQ+RjLS1stckUukwtBUZtaTUo0PDVeGF+NhY6F1IhUT6qOP
 S43C3vi0ObGm6FtcvGh9jP9acPGGmJ2swG42UvILuJSjjvUA3EErtfF0jJIRvkIq7SE=
X-Gm-Gg: Acq92OFOmxgcA7q5WxMU7ztmEU9xK4mbvvg4tCfbuLC1jCcrS1HbJK986kV/bYBeNZs
 rxZL1slruoyIfZi97aVTXAlGaUiSBzIxU76vRh+9A/byDTKHcr/RZrJwcHFRCvuQ+QKVjM53qn0
 l7WuuXQtge9rTra36jW/4oLkD/V3Vz5n7VuSJI9j/tA83L77TU8Wjs7MeaqWGEuLLdew2Wbcn10
 6G1C4c6H0oE8O9enIjWoOGaUBVy7q0AfdI4G8e6jrqE8scVzpfWuBgPxJvOqjvg5Wd490pWIkxF
 2QUO/GkBs7cyoSExwf/JzJRYE12vIGes+DGzJKNFN4Xrcs/Tg08PSt3YNTrxkxUMCLDLConVWef
 /21JcRVPyzpsmEnuDq0L+4N5409wW+DhaR/6GjKJCpZOKEO2PMNm//yHFgvQMCjWIsYaGTQpHyN
 vPJXjAkMTmpaBHwjSYpB2pkPwJlGmVuXYM6L9GWtgP
X-Received: by 2002:a05:6512:145c:10b0:5a8:e363:6f7e with SMTP id
 2adb3069b0e04-5a8e3637512mr316526e87.17.1778570065226; 
 Tue, 12 May 2026 00:14:25 -0700 (PDT)
Received: from stephen-xps.local ([62.119.255.230])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8a955e05dsm3178990e87.50.2026.05.12.00.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 00:14:24 -0700 (PDT)
Date: Tue, 12 May 2026 00:14:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: mark-blasko <blasko@google.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/6] net/gve: add hardware timestamping support
Message-ID: <20260512001421.43a98584@stephen-xps.local>
In-Reply-To: <20260511224354.872997-1-blasko@google.com>
References: <20260511224354.872997-1-blasko@google.com>
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

On Mon, 11 May 2026 22:43:48 +0000
mark-blasko <blasko@google.com> wrote:

> From: Mark Blasko <blasko@google.com>
> 
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
>  doc/guides/nics/features/gve.ini       |   1 +
>  doc/guides/nics/gve.rst                |  18 +++
>  doc/guides/rel_notes/release_26_07.rst |   3 +
>  drivers/net/gve/base/gve_adminq.c      | 127 +++++++++++++++++----
>  drivers/net/gve/base/gve_adminq.h      |  29 +++++
>  drivers/net/gve/base/gve_desc_dqo.h    |   8 +-
>  drivers/net/gve/gve_ethdev.c           | 148 ++++++++++++++++++++++++-
>  drivers/net/gve/gve_ethdev.h           |  39 +++++++
>  drivers/net/gve/gve_rx_dqo.c           |  26 +++++
>  9 files changed, 377 insertions(+), 22 deletions(-)
> 

Overall looks good, a little concerned about using ROBUST mutex.

AI review (with more opus 4.7)

Based on my review, here are the findings on this series. The patches mostly look reasonable but I have several concerns:

---

Some findings on this series.


[PATCH 1/6] net/gve: add thread safety to admin queue

The mutex is initialized with PTHREAD_MUTEX_ROBUST but pthread_mutex_lock
return values are never checked anywhere in the new code.

	pthread_mutexattr_setrobust(&mutexattr, PTHREAD_MUTEX_ROBUST);
	pthread_mutex_init(&priv->adminq_lock, &mutexattr);
	...
	pthread_mutex_lock(&priv->adminq_lock);

A robust mutex returns EOWNERDEAD on lock when the previous owner died
holding it, and transitions to permanent ENOTRECOVERABLE if
pthread_mutex_consistent() is not called before unlock. Either drop the
ROBUST attribute (matching the existing flow_rule_lock pattern in this
same driver, which uses only PROCESS_SHARED), or handle EOWNERDEAD and
ENOTRECOVERABLE explicitly.


[PATCH 3/6] net/gve: add AdminQ command for NIC timestamps

gve_adminq_alloc() explicitly zeroes every other adminq counter, but
the new adminq_report_nic_timestamp_cnt is not added to that list. The
counters get re-zeroed on every adminq_alloc, including from
gve_dev_reset() which calls gve_adminq_free() and then re-runs
gve_init_priv() -> gve_adminq_alloc(). After a device reset, every
counter except this new one will be back to zero, leaving inconsistent
stats. Add the assignment in gve_adminq_alloc().


[PATCH 4/6] net/gve: add periodic NIC clock synchronization

Unnecessary cast of void *:

	priv->nic_ts_report = (struct gve_nic_ts_report *)priv->nic_ts_report_mz->addr;

The same applies to the function-arg cast in gve_read_nic_clock:

	struct gve_priv *priv = (struct gve_priv *)arg;

Assignment from void * does not need a cast in C.

If the reschedule in gve_read_nic_clock fails:

	err = rte_eal_alarm_set(GVE_NIC_CLOCK_READ_PERIOD_MS * 1000,
				gve_read_nic_clock, priv);
	if (err < 0)
		PMD_DRV_LOG(ERR, "Failed to reschedule NIC clock read alarm, ret=%d", err);

no further callback will fire, no failures will accumulate, and
nic_ts_stale stays at whatever it was. If reschedule failure occurs
while stale is 0, the Rx datapath in 6/6 will keep attaching
reconstructed timestamps from an arbitrarily old base. Set nic_ts_stale
to 1 on reschedule failure so the Rx datapath stops trusting the cache.

gve_setup_nic_timestamp() discards the gve_alloc_nic_ts_report() error.
If the memzone allocation fails, priv->nic_timestamp_supported (set in
2/6) remains true, so dev_info_get() in 6/6 will advertise
RTE_ETH_RX_OFFLOAD_TIMESTAMP and read_clock() in 5/6 will return -EIO
on every call. Clear priv->nic_timestamp_supported on alloc failure so
the capability is advertised honestly.


[PATCH 6/6] net/gve: reconstruct HW timestamps from DQO

priv->mbuf_timestamp_offset sits in rte_zmalloc'd dev_private memory so
it starts at 0, but the fast path uses:

	priv->mbuf_timestamp_offset >= 0

The check is dead under the rxq->timestamp_enabled gate today, but the
>= 0 form suggests an "offset registered" semantic that isn't actually
enforced - a zero-initialized offset passes. Initialize
priv->mbuf_timestamp_offset to -1 in gve_dev_init(), or remove the
inner check since timestamp_enabled is the real gate.
