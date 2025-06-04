Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C80C5AE59
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 00:16:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17FC64065A;
	Wed,  4 Jun 2025 02:16:55 +0200 (CEST)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51]) by mails.dpdk.org (Postfix) with ESMTP id 299E5402DC
 for <dev@dpdk.org>; Wed,  4 Jun 2025 02:16:54 +0200 (CEST)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-6facc3b9559so73070456d6.0
 for <dev@dpdk.org>; Tue, 03 Jun 2025 17:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1748996213;
 x=1749601013; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VT3eEXIafhD3uEnrPFFsMR547hsCtR9JBpi0Lx97Fj8=;
 b=Nds6dtMTeNEncwAJyDa2Hs4Nqkz2kpxkRypWZiz2gVfP7uWGaL5xUJdkRgDnxi2Cp7
 czJiJKSyvOAkXL9e5P/t7ySKO/0f37IKg1mbiqZI0DSN1Q01pRV/6xboSa3fQD50e3Hl
 astrHobpHqH5GFyNwMvbRx0FuT3PogEC+IJV1sBBUwc9qOOIGT+nrTCEBpHkefqMxX3Q
 W5MnlOf5OgAhAlw9qKRaO1vNDaP3rf09iJbeDVc4yoMwFqeIM7YXCSkq7vkSQwM0iD8+
 /k5rdFR6OAUyH0YTB5cL4F+h02nb3UZmn7nNfuEkvvrEnYr17eqi0S2mX07bylR/SYS7
 awPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748996213; x=1749601013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VT3eEXIafhD3uEnrPFFsMR547hsCtR9JBpi0Lx97Fj8=;
 b=XnbvnbeP2UJP0/NsXDi0mzusUvZ6AON5iD13ZSUxhzvFwh1fdDPnAHA81QGAdWi/2l
 XniluCGSwpvkqAGN3C3zTUReSKZ/dNuyu0T4uBNMKtiyF8AjuZMKRYjW1a2udLGz+7H0
 tvxuOwzwpbIprGm3dnBVUquzfZOAkB7FR9U2GGORC5H1RImYu1bG9CPuIBoE7Sc8ffov
 p/SAIjSfZ59henpHTRWAXkEu4sO2l3KFAorZyKeneW8XdoetOTJsb5McEg7QfAxPorjp
 +lhJj305JlpUQZTicy6rq2SAhZV1sAWaRy+5Nlg/fjFjBBic6YkdoGaADdYHKLYLhAA9
 1qvA==
X-Gm-Message-State: AOJu0YwCyr1zgqLhKAJXnnRf3MmyJlylLoyat/yrEz1leKACQYYg14RG
 0ZRpkkUZqzAEG89PO/mp80KDK/SmFxFNUtJfpVgvUb5oEWK0/j4ZQDDnDTjU9+sxui4=
X-Gm-Gg: ASbGncsbuC26vQZICRF6vt8cWZi2gfpRLG9axPMvhCTSKPXt0ak1bOFGgd3uYtf2Lr2
 8XgSMQE1jYTMw5BaYc32smuYzv23WDJuXzrwdir/Iek7vvXFzziAjZXfQfZuxgRA+pPgGlYvKZ2
 40PiAPRPzafMN0SMg0QI2/Ga3ZIOaykM9rat4cU3OOxZdhLMlPAye7ji+KFG5H/cq4tOmDhSW8E
 ejbxEyQct+C+GIS7QOQf3fb4B5yD6h7RgqoT3WpuoRKFuseTb1CbLvXIFGhyd8OEQo8gDjbyd6G
 omg6fHDYwAbWAK56AAx1ohZr61twWRywTxV7B+laj14aHGMGNgRGA4dViPOLb41PoAN+D3f0oix
 a/EVuro4v1wr1I99jl61hK/CvfbwjPUXMkJFSdAQ=
X-Google-Smtp-Source: AGHT+IGh+PWsOKl5unPxZM/ag127HR0YuogjhiDirvC4L6kOcv9usIo4WgUc8vOHJcifvOC88dlI1w==
X-Received: by 2002:a05:6214:62d:b0:6fa:c1c6:c31 with SMTP id
 6a1803df08f44-6faf704dd3emr9930136d6.44.1748996213221; 
 Tue, 03 Jun 2025 17:16:53 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fac6d33891sm90971506d6.22.2025.06.03.17.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 17:16:52 -0700 (PDT)
Date: Tue, 3 Jun 2025 17:16:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ashish Sadanandan <ashish.sadanandan@gmail.com>
Cc: dev <dev@dpdk.org>
Subject: Re: ethdev use from secondary process
Message-ID: <20250603171649.7b4254da@hermes.local>
In-Reply-To: <CAN44U22Jq=Gap8YjKUeEUm4D8p5Th_M38YkCheKk67EpKmR-zw@mail.gmail.com>
References: <CAN44U22Jq=Gap8YjKUeEUm4D8p5Th_M38YkCheKk67EpKmR-zw@mail.gmail.com>
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

On Mon, 2 Jun 2025 14:35:04 -0600
Ashish Sadanandan <ashish.sadanandan@gmail.com> wrote:

> Hi everyone,
> I'm trying to use a secondary process to rx/tx packets through a NIC and
> running into segfaults due to some data structures not being populated on
> the secondary. I've figured out a solution, but it involves the use of
> internal APIs and I wanted to check with the community if there's a better
> way to do this.
> 
> I'm using DPDK 24.11 LTS for this test. The test code is at
> https://gist.github.com/praetorian20/0c1b69abbc7843d958da72fdf611a5d7. I'll
> describe the steps I'm following here.
> 
> Primary process:
> 
>    1. Command line: sudo LD_LIBRARY_PATH=/path/to/dpdk/shared/libs/
>    ./test-ethdev --main-lcore 0 --file-prefix=mpdemo --socket-mem=1024 -d
>    /path/to/dpdk/shared/libs/dpdk/pmds-25.0 --proc-type primary
>    2. Calls rte_eal_init
>    3. Registers message handler using  rte_mp_action_register
>    4. Waits indefinitely for CTRL+C
> 
> Secondary process:
> 
>    1. Command line: Same as primary, except --proc-type=secondary
>    2. Calls rte_eal_init
>    3. Registers message handler using  rte_mp_action_register
>    4. Creates a mempool using rte_pktmbuf_pool_create
>    5. Sends request message to primary using  rte_mp_request_async
> 
> Primary process (upon receiving the async request):
> 
>    1. Look up the mempool created by the secondary
>    2. Get port id for a particular ethdev using PCI address
>    3. Call rte_eth_dev_configure,  rte_eth_rx_queue_setup,
> rte_eth_tx_queue_setup
>    and  rte_eth_dev_start to start the ethdev
>    4. Send response to secondary
> 
> Secondary process (upon receiving response):
> 
>    1. Call  rte_eth_dev_get_port_by_name to fetch port id
>    2. Call  rte_eth_dev_attach_secondary and  rte_eth_dev_probing_finish to
>    initialize data structures. Without this the next step has segv
>    because rte_eth_fp_ops.rxq.data is nullptr
>    3. Call rte_eth_rx_burst to receive packets
> 
> 
> The above works but I have a few questions whether this process can be
> improved. I'm using an Nvidia ConnectX6 NIC (mlx5 driver) in case that
> matters.
> 
> 
>    - Are there public APIs I can call instead of
>    rte_eth_dev_attach_secondary and  rte_eth_dev_probing_finish?
>    - Is it possible to perform rte_eth_dev_configure, tx/rx queue setup and
>    rte_eth_dev_start from the secondary process? These functions return
>    various error codes when I try this.
>    - When I call rte_eth_dev_start on the primary, it's sending a message
>    to the secondary that goes unhandled. Is this a problem, and possibly the
>    reason for the unpopulated rte_eth_fp_ops on the secondary? This is the
>    error message I see from the primary:
> 
> EAL: Fail to recv reply for request
> > /var/run/dpdk/mpdemo/mp_socket_1094695_b7080eff23acd4:common_mlx5_mp
> > mlx5_net: port 2 failed to request stop/start Rx/Tx (5)  
> 
> 
>  Thanks for all your help,
> Ashish

Look at the mp examples.
You should not be calling attach and probing finish in the applications.
The primary must start first and has to always be running.


Also, some device do not support primary/secondary process check the documentation.
