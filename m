Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F050ECD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 16:09:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 283924027F;
	Thu, 18 Jun 2026 18:09:46 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id AE39A40268
 for <dev@dpdk.org>; Thu, 18 Jun 2026 18:09:44 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-30bc806fcf8so1326132eec.1
 for <dev@dpdk.org>; Thu, 18 Jun 2026 09:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781798984;
 x=1782403784; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=W7wpnVyzu83lFX6WrwopHhgOTH6qzlCCetfuglbAsFk=;
 b=eO67PlttYSQE5SQc2HvzBpXED2I1wrTlSKaSonVEuGrwKcfARzfrjJ777Tj3AmnXT4
 rfzaAakmtwXJGiVTQQLs5XIJ+vfdf7FzRpWK/dO3I6iX9YdXUeHEkMQaM70+PemoHAl9
 lh4+V9WN6qg5eUOnmpaM+0huJSBo4IfaiQ6d85lGiha/oHRXGRsj0CPonX9oBULzHehj
 +cBL/rUPJXna4jntyJlvti/dGHDo428S0kKdsomEudC3u0Txv8IpnWBhd01N50LYeoOd
 SEGzzwww1Oig4K7f6T1rdIBDuw9BeCEtz3Eb1prim7wYgqyOLeqq1ZCa+05R+3R4S5+D
 vUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781798984; x=1782403784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=W7wpnVyzu83lFX6WrwopHhgOTH6qzlCCetfuglbAsFk=;
 b=FMvzd1KHGJcMiLB1U+a1F352zCxYLLdVidVcLWziDOaeDHbcb/05aOGBPUB3/2AvgT
 GuOrfjZcluYtKaTHY1NIVDAiV206gmliKHxdBZmmesGbEHjbCSr+oVkukJLHNcXTW2S4
 i+PhB6qoImQE31WVvo8I+/yShNG3fseigxZK0H9ahDWGnzQO0sU2UPTW5mtwTTdzrPow
 GwZwdNn8RpSc+m4XkHMwrlBa2BaRz1cyy5cepLRVGumIQ4qeG4nWj5zr51BVIAkEJNML
 aluuG1pvozgtXue52qFHzU9FyDKG3U9QvXUIA8jf+1KFuKN0yGDQnH5Fz3NoE6tlfN+A
 wzMA==
X-Gm-Message-State: AOJu0YwZgnVq2gsn1OUyYEuzCJ1g9ShIJaUL62wu+rJApoPrNurWGyfK
 oit48f7PYuJXFZJhJnoGvjkvV+Ktp9dWcRmyvSmF2zK9dCu98SIY7KBOdPfQNb3MYPguQHLLyHg
 ZsDEv
X-Gm-Gg: AfdE7cl+ostZz8jRhgTBCO8wB8EWDByj4F6mgMY469OpsxIxGcpX2/do9VNmlQwQqGn
 AMxcidSyE1Dzk1pXvDFsABWi6tFUXq7wa4pjHPVGBrzZpbNlTOv1qFD/UONCEoV1abXCUS3IZOU
 brGkuYauS56EOEBbebH7+aCevVvcwgVadoRGzAw+sFMNeiuvV64EXgH26DGpRbhbLI4fC+rqN9F
 4E+Lp0Z9/9oCN8+0BvKtZ/B863k0o0J5blrzAYzb66yY82qctEbSDD5rOQSKuNes4iAcCbevmfB
 reqS1US+KGXVq/hkOik03lX3I+V5GQkujs1JYA/aC4UiNwdHCP4VWbMjho3d41IQayp0leAxavn
 rUWJTN49cS+4IDNHaCWvEmHC4lcOz3JzTfXrfNVEJMNHIyU18P0iWSDz7K24jA3xI5bgWzqAIIu
 yRLDLxu3M2GZZJ5k76grkv1XURO8iQVEdSYAcJVzdL+0kzhn3hKvhDCsWl0170UqbC
X-Received: by 2002:a05:7022:69f:b0:138:49ea:f468 with SMTP id
 a92af1059eb24-139a20b8d5bmr211257c88.2.1781798983181; 
 Thu, 18 Jun 2026 09:09:43 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1386f20ad25sm17702511c88.0.2026.06.18.09.09.42
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 09:09:42 -0700 (PDT)
Date: Thu, 18 Jun 2026 09:09:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH 0/2] eal: notify secondaries on primary exit
Message-ID: <20260618090940.6853e9cb@phoenix.local>
In-Reply-To: <20260507210152.410419-1-stephen@networkplumber.org>
References: <20260507210152.410419-1-stephen@networkplumber.org>
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

On Thu,  7 May 2026 13:58:35 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Bugzilla 1942: when a primary process exits cleanly, secondary
> processes other than testpmd do not get notified.  The notification
> mechanism added in 25.11 was placed in testpmd and used
> rte_mp_request_sync() with a testpmd-specific action name, so any
> non-testpmd secondary (dpdk-dumpcap, dpdk-pdump, dpdk-procinfo, or
> out-of-tree consumers) would log "Cannot find action: mp_testpmd"
> and the primary would block on the 5 second request timeout.
> 
> Putting application-specific IPC actions on a broadcast request path
> is the wrong layer.  Notification of primary exit is something every
> secondary needs and should come from EAL, not from each application.
> 
> Patch 1 reverts the testpmd-side mechanism (commit f96273c8e9d3).
> The secondary-side primary alive monitor (enable_primary_monitor)
> is preserved and continues to handle detection of primary exit via
> the existing alarm-based polling of rte_eal_primary_proc_alive().
> 
> Patch 2 adds a generic EAL-level notification.  On primary cleanup,
> rte_mp_channel_cleanup() broadcasts an MP_REQ_QUIT message to all
> known secondaries via rte_mp_sendmsg().  Secondaries register an
> internal action handler that tears down their own MP channel on
> receipt.  No new public API; no application changes required for
> any secondary, in-tree or out.
> 
> This is the minimum fix suitable for backport to 25.11 stable.
> It addresses the clean exit case.  The crash case (primary killed
> or signaled) continues to be handled by the existing
> rte_eal_primary_proc_alive() polling on the secondary side, which
> detects the primary's release of the config file lock.
> 
> A more complete solution using a connected socket type (SOCK_SEQPACKET)
> is planned since that can handle both planned and forced exiting
> of the primary.
> 
> Tested with testpmd (primary) and dpdk-dumpcap, dpdk-pdump,
> dpdk-procinfo (secondaries).
> 
> 
> Stephen Hemminger (2):
>   Revert "app/testpmd: stop forwarding in secondary process"
>   eal: notify secondary on primary exit
> 
>  app/test-pmd/testpmd.c           | 103 ++-----------------------------
>  lib/eal/common/eal_common_proc.c |  51 ++++++++++++++-
>  2 files changed, 53 insertions(+), 101 deletions(-)
> 

This is a real bug fix. Even if AI is being overly wordy in describing
it; what it does is move the notification from being testpmd -> testpmd only
to a more general primary -> secondary mechanism.

Without it can demonstrate the bug rather trivially with packet
capture tools (pdump or dumpcap)

Could this get reviewed?
