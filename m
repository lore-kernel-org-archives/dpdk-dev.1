Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75049C61DD9
	for <dpdk-dev@archiver.kernel.org>; Sun, 30 Aug 2026 04:31:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5492F402B3;
	Sun, 30 Aug 2026 06:31:07 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id AE3DC40264
 for <dev@dpdk.org>; Sun, 30 Aug 2026 06:31:05 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2d71a50caa9so29425185ad.0
 for <dev@dpdk.org>; Sat, 29 Aug 2026 21:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788064265;
 x=1788669065; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8IuzHFzgx1dCYylveiQbauwb3wz911Tiyo2t7uLDo+c=;
 b=pZZLXQDmtlMQzq4A09TNU6wiHtivEPMsRiI+jiBRO5zipO4qAITGjGIuXb4NB2l0d3
 NC8hTwpVQbZWyWdUxwJ9faPOrfrPi2MjBI9khG4pO6SFaOcMG3og3AKLDfURYWPJcKnI
 6LmwonD+N08hzjNPY6K57ncsY9S0bBTmYh9/mirH7Qk6KZkhKyYxsLY+vq/Vrje/ckfs
 rNU7Pm7Sak1VUMmen6bGI55oQp2jgbeIWFNtvBi5uaCMGogESFhCStRKa9IX8Pk/dLvl
 PmP90UfqdahEkU1aiAyBQarkzdeJTSn34HSh9Oh1AJfUZGH73sDNAOziMnVGpiamoJ1P
 b8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788064265; x=1788669065;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8IuzHFzgx1dCYylveiQbauwb3wz911Tiyo2t7uLDo+c=;
 b=eLpqXWSUBnCTUw2OysMvG2StKbz4SIZ4yVSSk7dcLhh19P6B36V9Lznc1GKlX9CJhK
 vTHYyVYaDrECMdBp+GqO6BeN0IdjprSi7fR6H9FDWUFYo9wbb7c7NGMA3UC/w45PDnGT
 YR25xOIFeK+tLMRD/XiZJ8qDrUeI2T1Ns7TkiY6bxhyI9sP3WJwCQR0xSNNvF+5bReTm
 6ouN583TPb57C8UbATaRItvcyiuTWQAkHZuo2kgqRxm9uKv/UbOVb4l/wKZFE/Y2YRXu
 LvgDA0QltCPerqUPw4LbF16nQVEVPwISZY0Asw4ryN+4XXAD5ygl57hVgwNEB4sGchy/
 q2zQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRsTu+o5heHPXYL12kRuhgodAl/MTbouF66Htawf0S5NQD+2+XaYfZ7TWg+yINnXLQxXQ=@dpdk.org
X-Gm-Message-State: AFuF++l2DH/1YGLHnTs4lIKXg2mbL88lubuiC+fKqM052IAgORLf4Uw9
 kzRLiol2yY5o6PLs7UOQifw6sHVjofJ8mHg1HtADPzrTI+tD6CMxBJWcvMtxZH3uaro=
X-Gm-Gg: AYBFou3bBbr5FXBjtoKwX7oyLx1ShgdPqYJ5oCRfTtlQ7ytzlq07QJkmDS9HIBPfnDY
 k/oBZ42lM19CUAh3Tv5sYStnA9S5KXybhxmLobF8StNqEnswo7MCS4UiZJx4KoqYha2+fvoho6l
 cw9G9O6fbhCusybe/3TWeqNBDijSGYwuXhkGAZ6gmdR9JU1dWIwZZEb9M4GWjyKq6Eh3o6Felra
 UEbJ2BmH5ObWuzYfZutHaRLKxjnkT9nD6r951n12xBrjT08VuWbzb6mbXT1WcRh1evHhkQ3rV2g
 EmbGr4gHi8pCPlu5snEMRDBhWi+IuVWRgA83lrdjMjZknw/4fWKY1y2Ct9XpqeDJ5JDRamVbzuY
 v0QPo6sYdBrpVKdOFAWNcM4r5Gf1hgRVMGi/vMI4NlpmVjiU+5+7iioLWIuqNZ/jqmSgzl3JCk7
 VktVu/jLOgVyBjOSqFE5wgImLCmlCt5IQydTiOyRTUH3sXgorXRxqTmFXXahqf8VQASP0akWWSB
 ly0DHaoU5Jxp0+u7ZqpD/17ue63AA==
X-Received: by 2002:a17:90b:49:b0:398:9be5:b41d with SMTP id
 98e67ed59e1d1-3989be5b4e2mr16505951a91.24.1788064264667; 
 Sat, 29 Aug 2026 21:31:04 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-398a14d3e83sm6797688a91.10.2026.08.29.21.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 21:31:04 -0700 (PDT)
Date: Sat, 29 Aug 2026 21:29:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Weijun Pan <wpan3636@gmail.com>
Cc: Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)"
 <humin29@huawei.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 dev@dpdk.org
Subject: Re: [RFC PATCH v4 2/2] net/bonding: restrict secondary control
 operations
Message-ID: <20260829212957.23395a9f@phoenix.local>
In-Reply-To: <20260830011445.168073-2-wpan3636@gmail.com>
References: <20260826161009.37875-1-wpan3636@gmail.com>
 <20260830011445.168073-1-wpan3636@gmail.com>
 <20260830011445.168073-2-wpan3636@gmail.com>
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

On Sat, 29 Aug 2026 20:14:45 -0500
Weijun Pan <wpan3636@gmail.com> wrote:

> diff --git a/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst b/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
> index 2fa1ac4028..a3f197c8b5 100644
> --- a/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
> +++ b/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
> @@ -254,6 +254,36 @@ Like all other PMD, all functions exported by a PMD are lock-free functions
>  that are assumed not to be invoked in parallel on different logical cores to
>  work on the same target object.
>  
> +Bonding device configuration and LACP runtime state are owned by the primary
> +process. Secondary processes may attach to an existing bonding device for
> +detach and supported query operations only.
> +
> +Supported secondary-process queries include device information, statistics,
> +link status, RETA query, RSS hash configuration, bonding mode, member list,
> +primary member, transmit policy, link monitoring configuration, and LACP
> +configuration. Private dump is limited to shared bonding information and skips
> +LACP runtime state in a secondary process.
> +
> +Control operations are restricted to the primary process. This includes
> +configuring, starting or stopping the device, setting up queues, changing
> +members, changing the bonding mode, selecting the primary member, changing the
> +transmit policy, changing link monitoring or propagation delays, updating RSS,
> +changing MAC addresses, changing MTU, configuring VLAN filters, changing
> +promiscuous or all-multicast mode, resetting statistics, configuring
> +``rte_flow`` rules, and changing 802.3ad settings, including aggregation
> +selection, external collect/distribute/slow-Tx controls, and dedicated queue
> +enable or disable.
> +
> +LACP runtime state queries, including ``rte_eth_bond_8023ad_member_info()``,
> +``rte_eth_bond_8023ad_ext_collect_get()``, and
> +``rte_eth_bond_8023ad_ext_distrib_get()``, are also restricted to the primary
> +process.
> +
> +Rx and Tx are not supported on a bonding device in a secondary process;
> +receive returns no packets and transmit drops packets. In a secondary process,
> +``rte_eth_dev_stop()`` returns ``-ENOTSUP`` and ``rte_eth_dev_close()`` is the
> +detach operation.
> +

That is way too long an explanation (thanks AI). Should just be short summary here.

> +* **Restricted bonding device control to the primary process.**
> +
> +  Bonding device configuration and LACP runtime state operations are now
> +  rejected in secondary processes. Secondary processes may detach and use
> +  supported query operations only.
> +

Once again, AI is being too wordy. It was always true that bonding control
did not work for secondary. And it is not really an API change.
Should be under Added items, like "Bonding allow data operations in secondary process"

> +static inline int
> +bond_check_primary(const char *op, int err)
> +{
> +	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
> +		return 0;
> +
> +	RTE_BOND_LOG(ERR, "%s not supported in non-primary process", op);
> +	return err;
> +}

When ever possible avoid using negatives in English speech.
Should just say "%s not supported in secondary process.
And returning different errors is awkward way to handle.
Just make helper that returns true/false and if false put that error code at
that location in caller.

Then you can eliminate lots of "int ret" in the calling code as well.


