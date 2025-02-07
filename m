Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9795CC02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 17:57:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B59B242ED5;
	Fri,  7 Feb 2025 18:57:23 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id A6A3642E90
 for <dev@dpdk.org>; Fri,  7 Feb 2025 18:57:22 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2163dc5155fso49797605ad.0
 for <dev@dpdk.org>; Fri, 07 Feb 2025 09:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738951042;
 x=1739555842; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MWmDyj0j21yC/NexwBGI/0buXeigP8Y5ZltEr/piolI=;
 b=Fv/g0UJZWNBZReCmU6ZQYttGKQpJyCwlUZ61Yeab7AjRYBD+XspK8782z8gTp3smC+
 5mn0ASoz3Hr7VZTgfGD59QItU/9bD6iFaS15dxt78dvfaAb+ndndk5ET9vVgE8zq8sQU
 25/sacuzwsCJC66Nq9QUG/pJGGVihtQVGKN59ce/b8J/W8XoVxUgUD5inQg86oOEFWhf
 JLZeQCiPNiGhlGHtBpYXJiLXiJO3AwIR9euJ7ROPdcGBJYb6mDI7ps9FGCBKIzfa5JDZ
 rPeQDKvmPTB1QMROrjSO/9FVYxUG9RUxT9iHf4IYWUMbT+JhYyeZs/m++5HO2l/jICma
 idmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738951042; x=1739555842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MWmDyj0j21yC/NexwBGI/0buXeigP8Y5ZltEr/piolI=;
 b=D9IIir6uVKd8ZkWiOHXLx0hA4sNNZIyVSf1+Qx3qqnb0G40LUfqVAqIyqwTHbKdzw4
 pnid963tnrFIpgUi1u6owRa6UD5dDRSdAbh7nMGoSNyoDrWfdWe0H0UBGUfwsF7NfFrX
 vlkmzHnyEEG/ZJb2cm1x8CtKvOdNP25XcSXjvC0iq6sZ48e3YW1iVXkLePStyYrtgrIE
 t7YCxv4gWVtfPBg4IryQ5WMM326GrXkV8WbxABrihi5pMjZXaInSlcyxVdzAI2xv3HYe
 x1uAoVojtj/gyHlC+SrPCAx74Uozk4sQ1e8H7dJFwuEIRnxyxj/Q1LvLOoLp7spoYbuS
 V8Tw==
X-Gm-Message-State: AOJu0Yxlfl9bodb6XhHtW+4GNht/0CXF7ZBGB/cXkBghCe31X2RAJJu8
 HsAGhzBgongMvpLziWo932nTdnSVbu43AEk587AAqjKhSz1upS8Pn0Kxkk7pIEg=
X-Gm-Gg: ASbGnctjkWDH7ayAVK4uNQjHipt2WAd1ce4aP0ey42d2+8FxvcFEVRCiJ8cOPx4omAF
 m2MC/jolsdg7WVDvk2TlMQKGF0hYX06I3xc3HwRMIprTO5b5cLapqtYOAktcBrTt/T640KSfSa7
 4ve246kTdtJCMnNNqTahSmG/WD94wppcEvFDViFK5r4356MbmHCyDX+DTW09/e33TlG0FQTNwLd
 8v03gZT7CiiTMqxp+F+A02dp4fIa+syQcW1R2gYFLISArzrdDwZYVsgUENT/NQM0hP7LTVkug3q
 tFOSyDK+Pl8MZbbgYUWB3gHKRb/q7Dcb4HrCdPAH2NvMW7bH3RejIE4fEoXND2NoXrsf
X-Google-Smtp-Source: AGHT+IHvKY7Adw4iaBexc2YW6SJGH+wO0Gm3v5veDsZNoswnU+JanCRzGpV+LWsdX6qNGhpa0MbJIg==
X-Received: by 2002:a17:902:e143:b0:216:50fb:5dfc with SMTP id
 d9443c01a7336-21f4e1cc2c1mr45371165ad.9.1738951041819; 
 Fri, 07 Feb 2025 09:57:21 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f36511106sm33430035ad.5.2025.02.07.09.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 09:57:21 -0800 (PST)
Date: Fri, 7 Feb 2025 09:57:19 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tudor Cornea <tudor.cornea@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] net/af_packet: fix socket close on device stop
Message-ID: <20250207095719.2c7a75f9@hermes.local>
In-Reply-To: <20250204164508.864080-1-tudor.cornea@gmail.com>
References: <20250204164508.864080-1-tudor.cornea@gmail.com>
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

On Tue,  4 Feb 2025 18:45:08 +0200
Tudor Cornea <tudor.cornea@gmail.com> wrote:

> Currently, if we call rte_eth_dev_stop(), the sockets are closed.
> If we attempt to start the port again, socket related operations
> will not work correctly.
> 
> This can be alleviated by closing the socket at the same place in
> which we currently free the memory, in eth_dev_close().
> 
> If an application calls rte_eth_dev_stop() on a port managed
> by the af_packet PMD, the port becomes unusable. This is in contrast
> with ports managed by other drivers (e.g virtio).
> 
> I also managed to reproduce the issue using testpmd.
> 
> sudo ip link add test-veth0 type veth peer name test-veth1
> 
> sudo ip link set test-veth0 up
> sudo ip link set test-veth1 up
> 
> AF_PACKET_ARGS=\
> "blocksz=4096,framesz=2048,framecnt=512,qpairs=1,qdisc_bypass=0"
> 
> sudo ./dpdk-testpmd \
>         -l 0-3 \
>         -m 1024 \
>         --no-huge \
>         --no-shconf \
>         --no-pci \
>         --vdev=net_af_packet0,iface=test-veth0,${AF_PACKET_ARGS} \
>         --vdev=net_af_packet1,iface=test-veth1,${AF_PACKET_ARGS} \
>         -- \
>         -i
> 
> testpmd> start tx_first  
> 
> Forwarding will start, and we will see traffic on the interfaces.
> 
> testpmd> stop
> testpmd> port stop 0  
> Stopping ports...
> Checking link statuses...
> Done
> testpmd> port stop 1  
> Stopping ports...
> Checking link statuses...
> Done
> 
> testpmd> port start 0  
> AFPACKET: eth_dev_macaddr_set(): receive socket not found
> Port 0: CA:65:81:63:81:B2
> Checking link statuses...
> Done
> testpmd> port start 1  
> AFPACKET: eth_dev_macaddr_set(): receive socket not found
> Port 1: CA:12:D0:BE:93:3F
> Checking link statuses...
> Done
> 
> testpmd> start tx_first  
> 
> When we start forwarding again, we can see that there is no traffic
> on the interfaces. This does not happen when testing with other PMD
> drivers (e.g virtio).
> 
> With the patch, the port should re-initialize correctly.
> 
> testpmd> port start 0  
> Port 0: CA:65:81:63:81:B2
> Checking link statuses...
> Done
> 
> Fixes: 364e08f2bbc0 ("af_packet: add PMD for AF_PACKET-based virtual devices")
> 
> Signed-off-by: Tudor Cornea <tudor.cornea@gmail.com>


Applied to next-net
Should this go to stable as well
