Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B73C0219B
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 01:55:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72B44402D5;
	Fri,  7 Feb 2025 02:55:47 +0100 (CET)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 5684C402A7
 for <dev@dpdk.org>; Fri,  7 Feb 2025 02:55:46 +0100 (CET)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2166651f752so34287345ad.3
 for <dev@dpdk.org>; Thu, 06 Feb 2025 17:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738893345;
 x=1739498145; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ev/E+yP5pYU6W6Ve3/puPXlFqBsmz6GcRbn+tGuEyKQ=;
 b=Wb2jpg9Kn5cWt5yaXA8Q4xqdVuJoFlHci3tmV1US1WGr1tVRcTNO5wBckUEyK+qWog
 A3d/P44lMmR6r53NV5LR+frmnpr/3JXLUBhJvvyGDNhhGz/bNX81RMkWmjJi2cndyB4n
 q7kHyDPJkJA/PpQ6y1sZZyN9g8aXLcmX+huLxbg5dM1qOuLuuD+622pdhH8gslWfHmLn
 og4ISsTE6LdRV5D+m3Ey0wVZnX9V0mpnJACpoeq9Awd09GnRt+nMlljAZFfjU9UtyG3Z
 zmgH3IpnutM7pyeeU8/wP5LnuDj2kvgVaKo8T96Jd0lEtb0vvCg6EEctCjihwuMcrPJX
 savQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738893345; x=1739498145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ev/E+yP5pYU6W6Ve3/puPXlFqBsmz6GcRbn+tGuEyKQ=;
 b=FHMp20OHlHEXPAYuCnLGcJBB9aOkkngYJgRKbaivDYtP6wiHxReUy6WoYMgeDrFZTL
 M7Wy/zwAUvojDMg7eDULnXjDnTrRkKMUhLpfE1RN1mlFUWcgUodK5FbQ4M/Txkmzaw0Z
 9fCLRMFJ4sbWb/uTZCmcgXokctn6DzZUKRTnLGMSwGzBnsobqqDJ83un/5XrgXHR2kke
 jqHjQ5Kyxj1xHvwrDFtH3J9dEoZQ5SUKPShL4z+NhqRVwYpfzJEe2A6kiR8indZWr42D
 6FYpBSqQQrB2/4P5rcuJTyiPHlDPXdKdsaxOR9IAk7SrAPIy1+7dCs/YSMX9qvt7x1QZ
 D4PA==
X-Gm-Message-State: AOJu0Yzh0Si9WGpFxT5thA97/Jl4LwB9D4wLzkLkC+gdF2LmvYjZttzs
 hnO6Nj0dj4g3BGtdKJa6NDJS4sDGa7o4TfvzHlhdo8pp8+WE5+qSO/6YZunGdqjP7aKZnDkw0CV
 8
X-Gm-Gg: ASbGnctQFlPL3mW15IKTxu8HevNf2m65638bYdcVtm6TbH/PkQUkmk3w7ZV7fL+HgMj
 pM4X0l0Kt8F6a3D8gkFgIZyQXn1Nj2Whj0MtJjwZhhomrPFKsdh49pSXDO7wq2me9B51heZ9geL
 8eVIoY0Ppf+mSvsaa7jLVnw7xUsrIlbjZTcET6+zcK3cRz1+nXURlq0s6yLdBTEE0jl43cD+At5
 3F91C2Ud2x9+BX7baMSJgsncA7mTER85tuMdsQcQxM5k9IBIKlpMOsE0ZIp4C7/RCENQzQYkze5
 lFELC9XmakzRaAfVyd5Q2HSMpI0llFH38w1ySLgXxn/rTx3/L8vigGib0hQ5J2Hu4qTN
X-Google-Smtp-Source: AGHT+IG2TPMxbfgvI+ZZM6G+/RoZgnIxrHF3hXzyFnfTVySNshINrKV+eDLh3f5Ec1qNCKIyoEU6VQ==
X-Received: by 2002:a17:902:ce86:b0:21f:13a6:d432 with SMTP id
 d9443c01a7336-21f4e6b8f1bmr25681655ad.14.1738893345288; 
 Thu, 06 Feb 2025 17:55:45 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f368b1493sm19305395ad.226.2025.02.06.17.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 17:55:45 -0800 (PST)
Date: Thu, 6 Feb 2025 17:55:42 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [RFC PATCH 0/5] Using shared mempools for zero-copy IO proxying
Message-ID: <20250206175542.044244b7@hermes.local>
In-Reply-To: <20230922081912.7090-1-bruce.richardson@intel.com>
References: <20230922081912.7090-1-bruce.richardson@intel.com>
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

On Fri, 22 Sep 2023 09:19:07 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> Following my talk at the recent DPDK Summit [1], here is an RFC patchset
> containing the prototypes I created which led to the talk.  This
> patchset is simply to demonstrate:
> 
> * what is currently possible with DPDK in terms of zero-copy IPC
> * where the big gaps, and general problem areas are
> * what the performance is like doing zero-copy between processes
> * how we may look to have new deployment models for DPDK apps.
> 
> This cover letter is quite long, as it covers how to run the demo app
> and use the drivers included in this set. I felt it more accessible this
> way than putting it in rst files in the patches. This patchset depends
> upon patchsets [2] and [3]
> 
> [1] https://dpdksummit2023.sched.com/event/1P9wU
> [2] http://patches.dpdk.org/project/dpdk/list/?series=29536
> [3] http://patches.dpdk.org/project/dpdk/list/?series=29538
> 
> Overview
> --------
> 
> The patchset contains at a high level the following parts: a proxy
> application which performs packet IO and steers traffic on a per-queue
> basis to other applications which connect to it via unix sockets, and a
> set of drivers to be used by those applications so that they can
> (hopefully) receive packets from the proxy app without any changes to
> their own code. This all helps to demonstrate the feasibility of zero-
> copy packet transfer between independent DPDK apps.
> 
> The drivers are:
> * a bus driver, which makes the connection to the proxy app via
>   the unix socket. Thereafter it accepts the shared memory from the
>   proxy and maps it into the running process for use for buffers and
>   rings etc. It also handled communication with the proxy app on behalf
>   of the other two drivers
> * a mempool driver, which simply manages a set of buffers on the basis
>   of offsets within the shared memory area rather than using pointers.
>   The big downside of its use is that it assumes all the objects stored
>   in the mempool are mbufs. (As described in my talk, this is a big
>   issue where I'm not sure we have a good solution available right now
>   to resolve it)
> * an ethernet driver, which creates an rx and tx ring in shared memory
>   for use in communicating with the proxy app. All buffers sent/received
>   are converted to offsets within the shared memory area.
> 
> The proxy app itself implements all the other logic - mostly inside
> datapath.c - to allow the connecting app to run. When an app connects to
> the unix socket, the proxy app uses memfd to create a hugepage block to
> be passed through to the "guest" app, and then sends/receives the
> messages from the drivers until the app connection is up and running to
> handle traffic. [Ideally, this IPC over unix socket mechanism should
> probably be generalized into a library used by the app, but for now it's
> just built-in]. As stated above, the steering of traffic is done
> per-queue, that is, each app connects to a specific socket corresponding
> to a NIC queue. For demo purposes, the traffic to the queues is just
> distributed using RSS, but obviously it would be possible to use e.g.
> rte_flow to do more interesting distribution in future.
> 
> Running the Apps
> ----------------
> 
> To get things all working just do a DPDK build as normal. Then run the
> io-proxy app. It only takes a single parameter of the core number to
> use. For example, on my system I run it on lcore 25:
> 
> 	./build/app/dpdk-io-proxy 25
> 
> The sockets to be created and how they map to ports/queues is controlled
> via commandline, but a startup script can be provided, which just needs
> to be in the current directory and name "dpdk-io-proxy.cmds". Patch 5 of
> this set contains an example setup that I use. Therefore it's
> recommended that you run the proxy app from a directory containing that
> file. If so, the proxy app will use two ports and create two queues on
> each, mapping them to 4 unix socket files in /tmp. (Each socket is
> created in its own directory to simplify use with docker containers as
> described below in next section).
> 
> No traffic is handled by the app until other end-user apps connect to
> it. Testpmd works as that second "guest" app without any changes to it.
> To run multiple testpmd instances, each taking traffic from a unique RX
> queue and forwarding it back, the following sequence of commands can be
> used [in this case, doing forwarding on cores 26 through 29, and using
> the 4 unix sockets configured using the startup file referenced above].
> 
> 	./build/app/dpdk-testpmd -l 24,26 --no-huge -m1 --no-shconf \
> 		-a sock:/tmp/socket_0_0/sock  -- --forward-mode=macswap
> 	./build/app/dpdk-testpmd -l 24,27 --no-huge -m1 --no-shconf \
> 		-a sock:/tmp/socket_0_1/sock  -- --forward-mode=macswap
> 	./build/app/dpdk-testpmd -l 24,28 --no-huge -m1 --no-shconf \
> 		-a sock:/tmp/socket_1_0/sock  -- --forward-mode=macswap
> 	./build/app/dpdk-testpmd -l 24,29 --no-huge -m1 --no-shconf \
> 		-a sock:/tmp/socket_1_1/sock  -- --forward-mode=macswap
> 
> NOTE:
> * the "--no-huge -m1" is present to guarantee that no regular DPDK
>   hugepage memory is being used by the app. It's all coming from the
>   proxy app's memfd
> * the "--no-shconf" parameter is necessary just to avoid us needing to
>   specify a unix file-prefix for each instance
> * the forwarding type to be used is optional, macswap is chosen just to
>   have some work done inside testpmd to prove it can touch the packet
>   payload, not just the mbuf header.
> 
> Using with docker containers
> ----------------------------
> 
> The testpmd instances run above can also be run within a docker
> container. Using a dockerfile like below we can run testpmd in a
> container getting the packets in a zero-copy manner from the io-proxy
> running on the host.
> 
>    # syntax=docker/dockerfile:1-labs
>    FROM alpine
>    RUN apk add --update alpine-sdk \
>            py3-elftools meson ninja \
>            bsd-compat-headers \
>            linux-headers \
>            numactl-dev \
>            bash
>    ADD . dpdk
>    WORKDIR dpdk
>    RUN rm -rf build
>    RUN meson setup -Denable_drivers=*/shared_mem -Ddisable_libs=* \
>         -Denable_apps=test-pmd -Dtests=false build
>    RUN ninja -v -C build
>    ENTRYPOINT ["/dpdk/build/app/dpdk-testpmd"]
> 
> To access the proxy, all the container needs is access to the unix
> socket on the filesystem. Since in the example startup script each
> socket is placed in its own directory we can use "--volume" parameter to
> give each instance it's own unique unix socket, and therefore proxied
> NIC RX/TX queue. To run four testpmd instances as above, just in
> containers the following commands can be used - assuming the dockerfile
> above is built to an image called "testpmd".
> 
> 	docker run -it --volume=/tmp/socket_0_0:/run testpmd \
> 		-l 24,26 --no-huge -a sock:/run/sock -- \
> 		--no-mlockall --forward-mode=macswap
> 	docker run -it --volume=/tmp/socket_0_1:/run testpmd \
> 		-l 24,27 --no-huge -a sock:/run/sock -- \
> 		--no-mlockall --forward-mode=macswap
> 	docker run -it --volume=/tmp/socket_1_0:/run testpmd \
> 		-l 24,28 --no-huge -a sock:/run/sock -- \
> 		--no-mlockall --forward-mode=macswap
> 	docker run -it --volume=/tmp/socket_1_1:/run testpmd \
> 		-l 24,29 --no-huge -a sock:/run/sock -- \
> 		--no-mlockall --forward-mode=macswap
> 
> NOTE: since these docker testpmd instances don't access IO or allocate
> hugepages directly, they should be runable without extra privileges, so
> long as they can connect to the unix socket.
> 
> Additional info
> ---------------
> 
> * Stats are available via app commandline
> * By default (#define in code), the proxy app only uses 2 queues per
>   port, so you can't configure more than that via cmdline
> * Any ports used by the proxy script must support queue reconfiguration
>   at runtime without stopping the port.
> * When a "guest" process connected to a socket terminates, all shared
>   memory used by that process is detroyed and a new memfd created on
>   reconnect.
> * The above setups using testpmd are the only ways in which this app and
>   drivers have been tested. I would be hopeful that other apps would
>   work too, but there are quite a few limitations (see my DPDK summit
>   talk for some more details on those).
> 
> Congratulations on reading this far! :-)
> All comments/feedback on this welcome.
> 
> Bruce Richardson (5):
>   bus: new driver to accept shared memory over unix socket
>   mempool: driver for mempools of mbufs on shared memory
>   net: new ethdev driver to communicate using shared mem
>   app: add IO proxy app using shared memory interfaces
>   app/io-proxy: add startup commands
> 
>  app/io-proxy/command_fns.c                 | 160 ++++++
>  app/io-proxy/commands.list                 |   6 +
>  app/io-proxy/datapath.c                    | 595 +++++++++++++++++++++
>  app/io-proxy/datapath.h                    |  37 ++
>  app/io-proxy/datapath_mp.c                 |  78 +++
>  app/io-proxy/dpdk-io-proxy.cmds            |   6 +
>  app/io-proxy/main.c                        |  71 +++
>  app/io-proxy/meson.build                   |  12 +
>  app/meson.build                            |   1 +
>  drivers/bus/meson.build                    |   1 +
>  drivers/bus/shared_mem/meson.build         |  11 +
>  drivers/bus/shared_mem/shared_mem_bus.c    | 323 +++++++++++
>  drivers/bus/shared_mem/shared_mem_bus.h    |  75 +++
>  drivers/bus/shared_mem/version.map         |  11 +
>  drivers/mempool/meson.build                |   1 +
>  drivers/mempool/shared_mem/meson.build     |  10 +
>  drivers/mempool/shared_mem/shared_mem_mp.c |  94 ++++
>  drivers/net/meson.build                    |   1 +
>  drivers/net/shared_mem/meson.build         |  11 +
>  drivers/net/shared_mem/shared_mem_eth.c    | 295 ++++++++++
>  20 files changed, 1799 insertions(+)
>  create mode 100644 app/io-proxy/command_fns.c
>  create mode 100644 app/io-proxy/commands.list
>  create mode 100644 app/io-proxy/datapath.c
>  create mode 100644 app/io-proxy/datapath.h
>  create mode 100644 app/io-proxy/datapath_mp.c
>  create mode 100644 app/io-proxy/dpdk-io-proxy.cmds
>  create mode 100644 app/io-proxy/main.c
>  create mode 100644 app/io-proxy/meson.build
>  create mode 100644 drivers/bus/shared_mem/meson.build
>  create mode 100644 drivers/bus/shared_mem/shared_mem_bus.c
>  create mode 100644 drivers/bus/shared_mem/shared_mem_bus.h
>  create mode 100644 drivers/bus/shared_mem/version.map
>  create mode 100644 drivers/mempool/shared_mem/meson.build
>  create mode 100644 drivers/mempool/shared_mem/shared_mem_mp.c
>  create mode 100644 drivers/net/shared_mem/meson.build
>  create mode 100644 drivers/net/shared_mem/shared_mem_eth.c
> 
> --
> 2.39.2
> 

This looked interesting but appears to be a dead end.
No more work, and never clear how it was different from memif.
Would need more documentation etc to be a real NIC.
If there is still interest resubmit it.
