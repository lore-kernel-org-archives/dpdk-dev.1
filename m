Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1524FC72C4
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Mar 2026 16:40:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEA4940647;
	Sun, 22 Mar 2026 17:40:33 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id AB36D402EE
 for <dev@dpdk.org>; Sun, 22 Mar 2026 17:40:32 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2ab46931cf1so37184405ad.0
 for <dev@dpdk.org>; Sun, 22 Mar 2026 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774197632;
 x=1774802432; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SvQ7cBOC3F9O8WohlU4v89lyscZ3fpB7z6XYSILhiek=;
 b=BqpEywkjRIM5v3FsS6BSeMOQskiBcUsz7kJjglQ5KwAlt7o04Y6IrsjeCR5hkvQ2Px
 NwNZB8iYUFcKRHLqECNsrIaHH4NqJWt5ViX27TSjk0eIRIXWKJzZ/04FwLpi2xeKgX3L
 goEJRc+2fzM4SBn1S1liu8+bspEbKVl1J432h4TFLGZez02lXgp47bqy4sEdajhktuuf
 YsLlgzYLv74HNFB8eWffQNpzvf8hHiUOWvTqs44wAdsFZ8lji/1qqN/cvXHOQM2spHnL
 CiOPH8VR69glghS8/YADQGGVu55mkeiLUsghBy41gsYKdLWyCuigLksPXGXH3HuiQQt/
 Nm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774197632; x=1774802432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SvQ7cBOC3F9O8WohlU4v89lyscZ3fpB7z6XYSILhiek=;
 b=BIyBR6BisoSov2vQapHm83KQvBx8P8/jgEeodgQ/GcMohF3yB81sLcB8iW4Oap4zI+
 y+63iXYMiqQl2SYrSRNoR2V+E1OKAnjr4L3ItziNESN7jryZZmpfTlqmdlOcsvFgymtW
 XPxsYNqQ/T99o1+/8bjLnDd6rFHalHKiw979Nl6MzhRR4hC7MZF4t36en6SPU4wjT5GC
 ANJYb7EB7qLhUmEQc511+cM34mX1jnaFoqa14SL72FUWt4+Kv4PK/ibYIPXqCeNxMWZT
 zMrK1hEdZ0mi32jwr5g5yO2e5JjIkE23CZcUs1huXIm9bSsn4hy8kFfxEClfZxQjL1fP
 Tl/Q==
X-Gm-Message-State: AOJu0YxBE2t0pi84qfvtf2Lj/WkBtxVsr44+nMeoEF3Pyqu1ndJ1+btp
 acnh2z6ls4ubreFraKfghqG1thjKBRzSD6eITZTsA60HZUgrYzf6N/xc91a491PO3qI=
X-Gm-Gg: ATEYQzwFDhco4MpZZ040aQXMat5lR17xGdrwWVWqqm6d/sxPnXMhf6YUMY0lCcJrXc6
 L+UTFfRiuw51hur9m5WthDL5oKKjnjee/A9GYpIIQmvToyowYEsLSQHr0ZOOXjlLIZuD1GXePVl
 v1+VWj/VBhPjQ2Dd/xDsyFp1Lg3hSy2rhBFa3syloalBzoPOcf9BgCa9ejCEEkUI6vVf2ZZzSgh
 cSV74ZTN/U3/48AQ65h3f+f3MrF9INO5i71+exuc0tmDmTsDc4y/K+2gFhrdP6y2sFK+R96YdEa
 KzrHBhtXR5sOtzcAVAFjHJfsr1D7htVZ5a5nibLk0pDIt+VEQGKh9NWmkXwOWixb5inHVlXmkID
 35NkgU49j53gQUelr8bT+bHqfR1D6XhxVfACLtkjdF6BJZLxUlfAOPP0/e4silgBhj5Oz/qyPxB
 D8+pNTR3A4crbG4wPMO9DrtIaRVcUeajtSx+I=
X-Received: by 2002:a17:902:ef43:b0:2b0:61f0:fc93 with SMTP id
 d9443c01a7336-2b0772410e6mr104979565ad.26.1774197631918; 
 Sun, 22 Mar 2026 09:40:31 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083516aa6sm110450285ad.9.2026.03.22.09.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 09:40:31 -0700 (PDT)
Date: Sun, 22 Mar 2026 09:40:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org, rjarry@redhat.com, nsaxena16@gmail.com,
 mb@smartsharesystems.com, adwivedi@marvell.com, jerinjacobk@gmail.com
Subject: Re: [RFC PATCH 2/4] fib: add VRF functional and unit tests
Message-ID: <20260322094022.2029d257@phoenix.local>
In-Reply-To: <20260322154215.3686528-3-vladimir.medvedkin@intel.com>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <20260322154215.3686528-3-vladimir.medvedkin@intel.com>
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

On Sun, 22 Mar 2026 15:42:13 +0000
Vladimir Medvedkin <vladimir.medvedkin@intel.com> wrote:

> +/* Get number of bits needed to encode VRF IDs */
> +static __rte_always_inline __rte_pure uint8_t
> +get_vrf_bits(uint32_t nb_vrfs)

This is test code, no need for __rte_always_inline.
