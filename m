Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77CB606A336
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KiGtjbMX
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09EFF402BC;
	Mon, 23 Nov 2026 17:50:55 +0100 (CET)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTPS id 879584027A
 for <dev@dpdk.org>; Mon, 23 Nov 2026 17:50:54 +0100 (CET)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-8b6b22be970so1325870b3a.1
 for <dev@dpdk.org>; Mon, 23 Nov 2026 08:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795452653;
 x=1796057453; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n+citxs+ixTEHU5poZkOPoM/MUNVGMajj/BXXJFTgy0=;
 b=KiGtjbMXyPDaykM8HsxacT+jpYmBHgYmGSAIyaTO++cZUyxWxcKIwA8W164TTrGUpC
 sJcmPlssmfUPDfw2ttPVtjVighvTejEoBrBtMO2bYKglVBMukY5MNJUHSvlLWwcxCoEy
 EhuS/EHgCMceMvNILl9vUiG3HOQLAsHRK8Rz6QwYnu9ei0FTH1S6zf8CEd+du4jWALxF
 2i+HH9F6H98IvG3+5Pl7sySd+T56+0a0jwoRGEYlRkThj2ZNqXbqWFG4mqxsBEX7Lrcc
 fIvR1mOTHMBxCh9dT+4PsN3g6px3Ta/t3Uk8MRqhCNz1GX2MHEWLzc48/yQXBNZ2aaot
 C4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795452653; x=1796057453;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n+citxs+ixTEHU5poZkOPoM/MUNVGMajj/BXXJFTgy0=;
 b=oiq518JY1BDiFDiivyWMFIM3o74FiQpXM/PjC9qTxI5lutrvG6TWtNxbFEWRVbMESQ
 7IEBuYWP5nGgGMBI0l0gYDpirmm4cvW77efeeS5ClUv1vY5dPdpfsWMKCpFTSE+Gnhpx
 WYlQX9a071Q2EjzgMgRvdrE15BB4nm9OQaBbu4UBb3VXG7JIOo8/kMQfjA42feBaI+Pt
 j7Ht4H3SeINnkhGP4B4Un2u1EkNsVVaQ1DdXaSo3NqfZwk8IuGc2LfbiUUrDEGOuP38k
 dE53pbtRolMXPJBnJqN+t5+WoAzxlEHdkLaOPPIceXA11vCARucGgqkSgeDvvh5DOG7s
 Ca4A==
X-Gm-Message-State: APuU4Z8bSn6SWVSAPrlNq+E60h3v/OxOxHOMo/ZsQ1AhBTuGIwq2M6kI
 yrHCwTvUI/BWSA4bbcGx1H9E15NcRXLcuBaYQc044aSYSY/DcKobTwsjC8t0vVK/ZcA=
X-Gm-Gg: AZFdTZdcEUKUeVvPOglPkl+ZRoxzwe6htugZTWkAE5cGvG581RBypS9ldeZMCTNfJsg
 7+2iH/wbLv6iU7B6Vms7lLDVTaPqMQRbpjG97lykhyqORl5sXP0HTxUglwT4SVUa+D2cw+CEpox
 2Q/8251Jg9yfNEGodcT2CHk4qqwCuiX4C4X/KocnV69/Om9hCeeuHoIHZ6byhe4/PsTs0OwKfWK
 9aa+iZYbZIfUCbaiNXtT9LYPCCZtDkAl5H/c5bbAjZCsLdIopvRcg2R7Dfv4WY/5R7b/4xXjSsQ
 1+U1PZzrLjNr0XJUq+XI5emZ2NpjLlQZ2bQhHDqNexIVXuHp2TfX2C82+MYHUywk0ZH/GVaCcW/
 DH4Q8KOfTuxwSV81Jq1Rbh8hCYmK2eiwTzAKoxDFhEDcywfAcm70cI5F93ugR3K6d/5jHUgsu7G
 A8GwxLXD617boyQiEKp42i69fVFdUcMoe24jOXjCddz147/7Aj+20X2/a2LXEEfZ5CeXLcq6pLH
 zjb7CoCJex7qoTpKGFGaVk3S5w/dLhO8rhnMlDcvP6HDOy3fGwnKHvwfXLFL4PGDc3RK846sDLm
 ar4hieKnKdia6j/DQaxYRIs9OCxjbcDLlqoT+kmW/yluyvIiige9rn3GEQM2+XmPd7ADZV4=
X-Received: by 2002:a05:6a00:4c0d:b0:8a6:1bfd:41fc with SMTP id
 d2e1a72fcca58-8c8792c35d0mr9732058b3a.1.1795452652855; 
 Mon, 23 Nov 2026 08:50:52 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87077babfsm5996026b3a.5.2026.11.23.08.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 08:50:52 -0800 (PST)
Date: Mon, 23 Nov 2026 08:50:50 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v2] app/testpmd: use burst IO for IEEE1588 forwarding
Message-ID: <20261123085050.75d472c2@phoenix.local>
In-Reply-To: <20261123122626.2253504-1-bruce.richardson@intel.com>
References: <20261118151155.2740034-1-bruce.richardson@intel.com>
 <20261123122626.2253504-1-bruce.richardson@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 23 Nov 2026 12:26:26 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

Since only called here:
>  static bool
> -ieee1588_packet_fwd(struct fwd_stream *fs)
> +ieee1588_process_packet(struct fwd_stream *fs, struct rte_mbuf *mb)
>  {

Make it void not bool

and drop the cast.

> +static bool
> +ieee1588_packet_fwd(struct fwd_stream *fs)
> +{
> +	struct rte_mbuf *pkts_burst[MAX_PKT_BURST];
> +
> +	const uint16_t nb_rx = common_fwd_stream_receive(fs, pkts_burst, nb_pkt_per_burst);
> +	for (uint16_t i = 0; i < nb_rx; i++)
> +		(void)ieee1588_process_packet(fs, pkts_burst[i]);
