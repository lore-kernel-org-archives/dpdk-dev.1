Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAE5CCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 15:59:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93F1142DD3;
	Fri, 17 Oct 2025 17:59:43 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id 45EC142DD5
 for <dev@dpdk.org>; Fri, 17 Oct 2025 17:59:42 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-77f67ba775aso2939792b3a.3
 for <dev@dpdk.org>; Fri, 17 Oct 2025 08:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760716781;
 x=1761321581; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2jHunm+1/i/udJXQm8cqdA59qcWhqQRnXtCB4jwFriI=;
 b=xGTt6Rf6emC4bL+CSj1a7FHIaMjO3mQpaAmFGyiVGaybhQxuzpX9eLJlAJkYaHAkZj
 QwTrlEt4sJ7qGTVm54RSqwpmMgVespWFeLIPE+bizMF07mivgzJEiDxY+RHj/b6x86HC
 YQwJJP73L0JSFuqacWen4jLkNT+ZnDIKtB0zPVQXJGUj/IowCs+BoUqqeufEZTCyfi5H
 VEr1o3M92n4uj8X9qypr04xhZdhJFP+VDLNZLah9SYfyLJAIh3YbXIWjrlV28R8mdQPV
 qRQJnekv7PNQDpzTGd1DH36tAdYMHw/BqEyltie4Zh7OpcQe4L7LB5FTHbrob5K487OM
 OzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760716781; x=1761321581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2jHunm+1/i/udJXQm8cqdA59qcWhqQRnXtCB4jwFriI=;
 b=MW8bL7CHjtZDxBxggamXX5MwsyX054IT97k55BcvJMQMqosNwnP+D/E+EQS6AHg2Qp
 65N27Pzk/b5ksmkiN3/c+OR89T9InJ0E3ja+m3MD75WfNXgff8zpXV23aSHA2nP2fAg3
 JUuUSLdGf48Chok2IFrtimvDQ711m9Ap6p2Js7WfAxCeL9xkO+fl0ngoGiZFJIVRKzZU
 Rq23npj6GyHqGchg+j8e4aOdUGbQp0tXH9yUL7yynsvkkncomsvfqwzTc5zB4SMa/t44
 ec7UwT/DOhPi2ykwfrtZZco5/kt9mScHn97DgJHoFLTelr+MNqavcrXVH97L/kavk5Wi
 AGlw==
X-Gm-Message-State: AOJu0YzCONgW5T6KIGDYJbnG/7IGn0agL/hpN6NGvT0cR/noKynWBn7g
 ja/tcZa6c3aDXvvVexaik/iL/POzWI0juMdlEACUeGMQUYhqerejzFuSpggUJIfZOEY=
X-Gm-Gg: ASbGncvAb4iazoiYKCiuLF23SDGbSBZec8xV35pY2Hv61vu4MTT7UZt8rNaas0l+x23
 MkJaPyZRH0p/+T0b10Mpp3CV6pOJlUoLiTsqornXDnAY+swpwzyyQaSX409+HTbYflbu1fOxigs
 HcmxlovkquhmPzVE0Vw9gH13OdIezo7QyHhrrlDC5igWsAq1QKT+2+YuCYWiB+bT4YpPCfnTaUB
 tcF7cNsj+4ibxf1Ovu5NneOUxEAn20PvdEfl9ocFhNHkLz61MHumzk1kuUoQ+GM9yYzdBbKdtpj
 88HOXisXKmWsjtj+e4pRFbpA1b7XqoqrGl4ykk1CO0Kh3BpTlDbFispWX6H7Wtg0C/uN1+TINaH
 lwy7ruVxRr4pZWKoJz6e17rNH1lKvIgAudL/4qX+9vKG+AOhqod227Mt6XLCN7o2YencsQigZrg
 elHygW6dJ+25y7PsX87awpXgYvXcJoGsKMf1tgXWD1u70kSm7Omg==
X-Google-Smtp-Source: AGHT+IF3iIOxjG845txy0W2T+Tzm9BchKwNUYd2YXZ7gmm1LwDgDHOlCoGmUh+sUSgenbRFmXy9Xxw==
X-Received: by 2002:a05:6a00:2308:b0:792:52ab:d9fe with SMTP id
 d2e1a72fcca58-7a220440d9fmr5096306b3a.0.1760716781296; 
 Fri, 17 Oct 2025 08:59:41 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992b060a38sm26542041b3a.5.2025.10.17.08.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 08:59:41 -0700 (PDT)
Date: Fri, 17 Oct 2025 16:38:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Keith Wiles <keith.wiles@intel.com>, Pascal Mazon
 <pascal.mazon@6wind.com>, stable@dpdk.org
Subject: Re: [PATCH dpdk] net/tap: fix interrupt callback crash after failed
 start
Message-ID: <20251017163854.2bd86108@phoenix.lan>
In-Reply-To: <20251017121946.421658-2-rjarry@redhat.com>
References: <20251017121946.421658-2-rjarry@redhat.com>
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

On Fri, 17 Oct 2025 14:19:47 +0200
Robin Jarry <rjarry@redhat.com> wrote:

> After moving a tap linux net device to a different namespace,
> tap_link_set_up fails with an -ENODEV error. Indeed it relies on an
> ioctl call using the interface name as argument:
> 
> 	/* with ifr->ifrn_name = "dtapX" */
> 	ioctl(pmd->ioctl_sock, SIOCGIFFLAGS, ifr)
> 
> This causes rte_eth_dev_stop() to do nothing since the device is not
> seen as started. And then, when removing the device, the interrupt
> callbacks are left there.
> 
> If they are invoked, they will be so with a "freed" device pointer:
> 
> Thread 2 "dpdk-intr" hit Breakpoint 1, tap_dev_intr_handler
>     at ../drivers/net/tap/rte_eth_tap.c:1689
> 1689            struct pmd_internals *pmd = dev->data->dev_private;
> (gdb) p *dev
> $2 = {
>   ...
>   data = 0x0,
>   ...
>   state = RTE_ETH_DEV_UNUSED,
>   security_ctx = 0x0
> }
> 
> This causes a crash when dereferencing the data pointer.
> 
> When tap_link_set_up fails, ensure to unregister the interrupt callbacks
> that were just reinstalled.
> 
> Cc: stable@dpdk.org
> Fixes: c0bddd3a057f ("net/tap: add link status notification")
> 
> Signed-off-by: Robin Jarry <rjarry@redhat.com>

Queued to next-net
