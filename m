Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C926CD4855
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 08:26:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C35940264;
	Tue, 12 May 2026 10:26:09 +0200 (CEST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52]) by mails.dpdk.org (Postfix) with ESMTP id EBB7C400D7
 for <dev@dpdk.org>; Tue, 12 May 2026 10:26:07 +0200 (CEST)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-5a8e33556c0so478867e87.0
 for <dev@dpdk.org>; Tue, 12 May 2026 01:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778574367;
 x=1779179167; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TP29AFtgyeig5hHrZ+MEfTab2wvHMykzBP+L2MdtqwY=;
 b=QJPb5k+VSUlJuBGODYLs7wwxaZfWAjm8eINcrQ7kHXED5tspwc7kUwIDuULljX7fvc
 R6CpD9BdAYcvp0kiQjttOMXA6xHrR2NfPGWlVa5w65kNpqkdRlJAxIKhUioe76NLq+8n
 daCya5cSo8K9JtiLU6pfnYh18mrelFCNETNQH/2XNXJgfZJZ2JFUyKCfHj+LuI3Xgnqj
 CSlaHHVYpygTEsYYs5U71GURETHCtal+UUX3IhdDOuX/sWDO656mxwZtPP0UHWay6NGl
 JH+tI8Hyxz/ejb3RinwWmhr+L+i+O7LQWNlt/arn6DP2c0kXZBmA5Rm0CybBAHa/1ts/
 FIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778574367; x=1779179167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TP29AFtgyeig5hHrZ+MEfTab2wvHMykzBP+L2MdtqwY=;
 b=pOXGDgrN5kCZvw37X7QtOPFn5gDWV5eoslweJacwjeRcJxwBH/Qjy4Uz87awVkqiSl
 VdZPcWfE0/a0rUWigQlpbOWP71I0s4abgQBH8sPiyCl1R61430B4e6HPYjKUzSceSjiz
 kV/WG0YPrf4tRijHJxH0brNC7mQ2EGgF+EBRdCOnS8gv6n4T99qNMatP3LcKs0GEOhVQ
 NVN1FXSdqE9tE6TYjb9Mb8gtURwfyfauefGrSB6Kt5R7jjp9f5UGTbPjBh7cxLilZn6a
 sf0rsT7J8fa2xVskfexQ9vBYGLXAgrXHFpn9bm6BICTVRlHifhk5BXR2SKBwg31AaoXL
 WTJw==
X-Gm-Message-State: AOJu0Yz4leZSdzij25MnJu/wvtObbQf++yuUwI33Ycwlq2c1v9nP82ca
 QrjPHkD9RCgXDxqIjI+kh+MxVcenru/qNkTSoZPZOBirdgumMVFmhppZImgb4hxXBZE=
X-Gm-Gg: Acq92OEFxn7eMn/HxQQ/WkKfB+BaWWLiekVLZN1cqhndutr/X+melRd9yLkh3urkHBc
 V5V6gTVGxpok2bgwOv7+XDlbw408W6stfng2eGAui7415+kCWplUyH8E3rKjWDLPQuwPPu6/nBd
 8M+MiJpwGfTUQBS4Xk/BK8ifltfEw+fbMYc50w2Mzsur8XvO6/0Hwkti0NELPLU8IlcP2Q8iBGe
 F0NBLRK9IF5IHSVJUzgrhoUi8Qy+eo3e7dhVGs4aZcHVgeKTxU09WWvSaZx8vBya8V797g8vNa5
 qyJHGV2vt5OtNFwfheQ2GdDunKexJNX8S/Z8p+9KkLoJT8rvGFjZTh/R59neLjr50mfhEYvXLL1
 0bbyBx9ZVNJnyx8jVCTF7mECiqFrN9zi+KMHT+yHCGcOlyW5s0SGbSRUh4gN+F9FgG/f/EBQyt3
 iqU7N6ApD724GfLx/3Tlv2Zo7DTjp8fT0yYo3ctSUk
X-Received: by 2002:a05:6512:33c9:b0:5a4:a85:ba3b with SMTP id
 2adb3069b0e04-5a8e0f15b21mr827803e87.19.1778574367194; 
 Tue, 12 May 2026 01:26:07 -0700 (PDT)
Received: from stephen-xps.local ([62.119.255.230])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8a95155d5sm3186543e87.2.2026.05.12.01.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 01:26:06 -0700 (PDT)
Date: Tue, 12 May 2026 10:26:03 +0200
From: Stephen Hemminger <stephen@networkplumber.org>
To: mark-blasko <blasko@google.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>, "Jasper Tran
 O'Leary" <jtranoleary@google.com>
Subject: Re: [PATCH 6/6] net/gve: reconstruct HW timestamps from DQO
Message-ID: <20260512102603.6637cf79@stephen-xps.local>
In-Reply-To: <20260512005057.944672-7-blasko@google.com>
References: <20260512005057.944672-1-blasko@google.com>
 <20260512005057.944672-7-blasko@google.com>
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

On Tue, 12 May 2026 00:50:55 +0000
mark-blasko <blasko@google.com> wrote:

> diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
> index 1b012c4776..db886f19cf 100644
> --- a/doc/guides/rel_notes/release_26_07.rst
> +++ b/doc/guides/rel_notes/release_26_07.rst
> @@ -62,6 +62,9 @@ New Features
>    * ``-A`` or ``--no-auto-probing`` disable the initial bus probing: no device is probed during
>      ``rte_eal_init`` and the application is responsible for probing each device,
>    * ``--auto-probing`` enables the initial bus probing, which is the current default behavior.
> +* **Updated Google GVE net driver.**
> +
> +  * Added hardware timestamping support on DQO queues.
>  
>  * **Updated PCAP ethernet driver.**

Need blank line between release note entries.
Run doc build to see errors like this
