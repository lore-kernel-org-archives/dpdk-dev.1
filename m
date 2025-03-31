Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA81C3600B
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 15:14:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1A02402DF;
	Mon, 31 Mar 2025 17:14:36 +0200 (CEST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id 49920402DA
 for <dev@dpdk.org>; Mon, 31 Mar 2025 17:14:35 +0200 (CEST)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-227d6b530d8so82162215ad.3
 for <dev@dpdk.org>; Mon, 31 Mar 2025 08:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743434074;
 x=1744038874; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K80EyaT/YCqOe549JVAzUesvi04SAoEq4noKO6rxGYM=;
 b=wHXooID7A8VUPwCpwx2JdsU8QGY0d7t0QW+APei7MXo+JTRtnp/grJolyxl/0iFjG6
 fjYWlOG7VuSaVJbigcx60CYl+lVziAudUzJ13z7tGqFPqiFLZ1Qa6b/cHdJYjzjTyHrl
 wtv8otcsROCN81qqEkVegY5x1eL5h0/uxvbI+E4hFrnclzrjDdcCNWS3OqMN7mYwVbm7
 4tzh2Og7SGFMG938PBO+L7eK3xJHu6x9YjmxjTuDtr39pOIijsI/7zdSXx9gXt7q5/AT
 F/V2F0ZfMInruOk3SPw5YS31JVMAOyw92FVonpjvb4UDa7nY4kdDf+oOM77lroyMh3zl
 KCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743434074; x=1744038874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K80EyaT/YCqOe549JVAzUesvi04SAoEq4noKO6rxGYM=;
 b=oGjqJ7rQE1EuZEDwsjf5/1Cw31gufGbSyeu9oDfCSCOARl7MHkdClkx+GPSnsWnKF+
 Cyxc5JG174LScrxjYMD06oYMxPdvaMfroDBM/mu6sxRcVn4tuFvFvzM8vUeZn7Aq7dGS
 /VYnXCQMCo6Qa7gvbT4NZvRwV7w8RqL7Lxj4MYKRh+kZh23RT0/cDv9vlJ6sLq1G36Ja
 Qve2r+pnD/y3hnl8tAibDmRfLpsDtwEjM8M/uRdJ8hD3UoOj5pDvNzPrBhH+WwO1dd03
 NP2nRAYy9BWdCIGShY8ANGdeXhsyV36yayIu/8OvhTuZFXRYJuWuDhzAO3qy+f8zFJ3w
 ILVg==
X-Gm-Message-State: AOJu0Yw9YML9M0YIG9Osyrf0Dn237Fd57AVZpqAbkoA5ck+O/IGZjJXI
 9j9LiY9ZvZTivT/Wjj8E5dSxYDf/R3qsMCNEOmlkXQ6Ug7G8QI/n2Xl5JRIq8bE=
X-Gm-Gg: ASbGnctYjjKRRtqUcfUjIx0toS+oVQ8SnZss4Bw9DCpw6lXXVQf+oQewv+PGGQqgAAC
 P9oYBK/Y2ZtsGA9O1nS1+9JlYp6cFM8CrP3Wyu3qv6BzTcKCQEUt6TZMeqfSvol3jUcrqDKhCKH
 KC3tjSZixDVMti5s458F9XmvpanRsO4lhGzrE79CujIryXlP4ZF/d5YSfQ1fqghHHk4e2OkRKGf
 GCSfy2PCdjy90Saijc4mhad3EmRNMFR9islSCp0S5R///jq0rityunt2ZAGiW+yk/m4NrXBjbfS
 vEV34+JatFpA8HPN1LIJ2aDWeQnyaAG1KeK/WJf/Uk2d/nfu6FpOpexCPkwxYzMcn+3uOGrhMiG
 AUthX0ymCEE4/dEwSkhokz2+7MFy15x4=
X-Google-Smtp-Source: AGHT+IGKlRU/uW1e3+47yuoSDzUI/aRkIzzxCLxeY1vKA8KmMlU3ZIlzAHTRGnQb6XbgxSygjAcvoA==
X-Received: by 2002:a05:6a00:1956:b0:736:a82a:58ad with SMTP id
 d2e1a72fcca58-739804346c7mr13110695b3a.15.1743434073560; 
 Mon, 31 Mar 2025 08:14:33 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7397109c407sm7261147b3a.137.2025.03.31.08.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 08:14:33 -0700 (PDT)
Date: Mon, 31 Mar 2025 08:14:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bhagyada Modali <bhagyada.modali@amd.com>
Cc: <dev@dpdk.org>, <ssebasti@amd.com>, <rningoji@amd.com>
Subject: Re: [PATCH] dma\ae4dma: added AMD user space DMA driver
Message-ID: <20250331081431.37ce9407@hermes.local>
In-Reply-To: <20250309084526.972512-1-bhagyada.modali@amd.com>
References: <20250309084526.972512-1-bhagyada.modali@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Sun, 9 Mar 2025 14:15:26 +0530
Bhagyada Modali <bhagyada.modali@amd.com> wrote:

> Added a user-space driver with support for the AMD EPYC
> 4th Generation DMA (AE4DMA) offload engine.
>=20
> Implementation of new user-space driver supporting
> DMA memory copy offload on AMD EYPC 9004 & 8004 systems
> (Genoa and Siena processors).
>=20
> Signed-off-by: Bhagyada Modali <bhagyada.modali@amd.com>
> ---
>  app/test-dma-perf/benchmark.c        |  24 +-
>  app/test-dma-perf/config.ini         | 134 ++++--
>  app/test-dma-perf/main.c             |   2 -
>  app/test/test_dmadev.c               |  43 +-
>  drivers/dma/ae4dma/ae4dma_dmadev.c   | 656 +++++++++++++++++++++++++++
>  drivers/dma/ae4dma/ae4dma_hw_defs.h  | 225 +++++++++
>  drivers/dma/ae4dma/ae4dma_internal.h | 125 +++++
>  drivers/dma/ae4dma/meson.build       |   7 +
>  drivers/dma/meson.build              |   1 +
>  lib/mempool/rte_mempool.h            |   2 +-
>  usertools/dpdk-devbind.py            |   5 +-
>  11 files changed, 1146 insertions(+), 78 deletions(-)
>  create mode 100644 drivers/dma/ae4dma/ae4dma_dmadev.c
>  create mode 100644 drivers/dma/ae4dma/ae4dma_hw_defs.h
>  create mode 100644 drivers/dma/ae4dma/ae4dma_internal.h
>  create mode 100644 drivers/dma/ae4dma/meson.build
>=20
> diff --git a/app/test-dma-perf/benchmark.c b/app/test-dma-perf/benchmark.c
> index 6d617ea200..a9aff8191b 100644
> --- a/app/test-dma-perf/benchmark.c
> +++ b/app/test-dma-perf/benchmark.c
> @@ -266,17 +266,35 @@ error_exit(int dev_id)
>  	rte_exit(EXIT_FAILURE, "DMA error\n");
>  }
> =20
> +static void
> +await_hw(int16_t dev_id, uint16_t vchan)
> +{
> +	enum rte_dma_vchan_status st;
> +
> +	if (rte_dma_vchan_status(dev_id, vchan, &st) < 0) {
> +		/* for drivers that don't support this op, just sleep for 1 us */
> +		rte_delay_us_sleep(1);
> +		return;
> +	}
> +
> +	/* for those that do, *max* end time is one second from now, but all sh=
ould be faster */
> +	const uint64_t end_cycles =3D rte_get_timer_cycles() + rte_get_timer_hz=
();
> +	while (st =3D=3D RTE_DMA_VCHAN_ACTIVE && rte_get_timer_cycles() < end_c=
ycles) {
> +		rte_pause();
> +		rte_dma_vchan_status(dev_id, vchan, &st);
> +	}
> +}
> +
> +
>  static inline void
>  do_dma_submit_and_poll(uint16_t dev_id, uint64_t *async_cnt,
>  			volatile struct worker_info *worker_info)
>  {
>  	int ret;
>  	uint16_t nr_cpl;
> -
>  	ret =3D rte_dma_submit(dev_id, 0);
>  	if (ret < 0)
>  		error_exit(dev_id);
> -
>  	nr_cpl =3D rte_dma_completed(dev_id, 0, MAX_DMA_CPL_NB, NULL, NULL);
>  	*async_cnt -=3D nr_cpl;
>  	worker_info->total_cpl +=3D nr_cpl;
> @@ -311,12 +329,14 @@ do_dma_plain_mem_copy(void *p)
>  			ret =3D rte_dma_copy(dev_id, 0, rte_mbuf_data_iova(srcs[i]),
>  				rte_mbuf_data_iova(dsts[i]), buf_size, 0);
>  			if (unlikely(ret < 0)) {
> +				await_hw(dev_id, 0);
>  				if (ret =3D=3D -ENOSPC) {
>  					do_dma_submit_and_poll(dev_id, &async_cnt, worker_info);
>  					goto dma_copy;
>  				} else
>  					error_exit(dev_id);
>  			}
> +
>  			async_cnt++;
> =20
>  			if ((async_cnt % kick_batch) =3D=3D 0)
> diff --git a/app/test-dma-perf/config.ini b/app/test-dma-perf/config.ini
> index 61e49dbae5..4fa8713e89 100644
> --- a/app/test-dma-perf/config.ini
> +++ b/app/test-dma-perf/config.ini
> @@ -61,57 +61,95 @@
> =20
>  [case1]
>  type=3DDMA_MEM_COPY
> -mem_size=3D10
> -buf_size=3D64,8192,2,MUL
> -dma_ring_size=3D1024
> -kick_batch=3D32
> +mem_size=3D64
> +buf_size=3D32768
> +dma_ring_size=3D32
> +kick_batch=3D4
>  src_numa_node=3D0
>  dst_numa_node=3D0
>  cache_flush=3D0
>  test_seconds=3D2
> -lcore_dma0=3Dlcore=3D10,dev=3D0000:00:04.1,dir=3Dmem2mem
> -lcore_dma1=3Dlcore=3D11,dev=3D0000:00:04.2,dir=3Dmem2mem
> +lcore_dma0=3Dlcore=3D4,dev=3D0000:04:00.1-ch0,dir=3Dmem2mem
> +lcore_dma1=3Dlcore=3D5,dev=3D0000:04:00.1-ch1,dir=3Dmem2mem
> +lcore_dma2=3Dlcore=3D7,dev=3D0000:64:00.1-ch0,dir=3Dmem2mem
> +lcore_dma3=3Dlcore=3D8,dev=3D0000:64:00.1-ch1,dir=3Dmem2mem
> +lcore_dma4=3Dlcore=3D14,dev=3D0000:41:00.1-ch0,dir=3Dmem2mem
> +lcore_dma5=3Dlcore=3D15,dev=3D0000:41:00.1-ch1,dir=3Dmem2mem
> +lcore_dma6=3Dlcore=3D17,dev=3D0000:21:00.1-ch0,dir=3Dmem2mem
> +lcore_dma7=3Dlcore=3D18,dev=3D0000:21:00.1-ch1,dir=3Dmem2mem
> +;lcore_dma0=3Dlcore=3D13,dev=3D0000:41:00.1-ch0,dir=3Dmem2mem
> +;lcore_dma1=3Dlcore=3D14,dev=3D0000:41:00.1-ch1,dir=3Dmem2mem
> +;lcore_dma2=3Dlcore=3D15,dev=3D0000:41:00.1-ch2,dir=3Dmem2mem
> +;lcore_dma3=3Dlcore=3D16,dev=3D0000:41:00.1-ch3,dir=3Dmem2mem
> +;lcore_dma4=3Dlcore=3D17,dev=3D0000:41:00.1-ch4,dir=3Dmem2mem
> +;lcore_dma5=3Dlcore=3D18,dev=3D0000:41:00.1-ch5,dir=3Dmem2mem
> +;lcore_dma6=3Dlcore=3D19,dev=3D0000:41:00.1-ch6,dir=3Dmem2mem
> +;lcore_dma7=3Dlcore=3D20,dev=3D0000:41:00.1-ch7,dir=3Dmem2mem
> +;lcore_dma8=3Dlcore=3D21,dev=3D0000:41:00.1-ch8,dir=3Dmem2mem
> +;lcore_dma9=3Dlcore=3D22,dev=3D0000:41:00.1-ch9,dir=3Dmem2mem
> +;lcore_dma10=3Dlcore=3D23,dev=3D0000:41:00.1-ch10,dir=3Dmem2mem
> +;lcore_dma11=3Dlcore=3D24,dev=3D0000:41:00.1-ch11,dir=3Dmem2mem
> +;lcore_dma12=3Dlcore=3D25,dev=3D0000:41:00.1-ch12,dir=3Dmem2mem
> +;lcore_dma13=3Dlcore=3D26,dev=3D0000:41:00.1-ch13,dir=3Dmem2mem
> +;lcore_dma14=3Dlcore=3D27,dev=3D0000:41:00.1-ch14,dir=3Dmem2mem
> +;lcore_dma15=3Dlcore=3D28,dev=3D0000:41:00.1-ch15,dir=3Dmem2mem
> +;lcore_dma16=3Dlcore=3D32,dev=3D0000:21:00.1-ch0,dir=3Dmem2mem
> +;lcore_dma17=3Dlcore=3D33,dev=3D0000:21:00.1-ch1,dir=3Dmem2mem
> +;lcore_dma18=3Dlcore=3D34,dev=3D0000:21:00.1-ch2,dir=3Dmem2mem
> +;lcore_dma19=3Dlcore=3D35,dev=3D0000:21:00.1-ch3,dir=3Dmem2mem
> +;lcore_dma20=3Dlcore=3D36,dev=3D0000:21:00.1-ch4,dir=3Dmem2mem
> +;lcore_dma21=3Dlcore=3D37,dev=3D0000:21:00.1-ch5,dir=3Dmem2mem
> +;lcore_dma22=3Dlcore=3D38,dev=3D0000:21:00.1-ch6,dir=3Dmem2mem
> +;lcore_dma23=3Dlcore=3D39,dev=3D0000:21:00.1-ch7,dir=3Dmem2mem
> +;lcore_dma24=3Dlcore=3D40,dev=3D0000:21:00.1-ch8,dir=3Dmem2mem
> +;lcore_dma25=3Dlcore=3D41,dev=3D0000:21:00.1-ch9,dir=3Dmem2mem
> +;lcore_dma26=3Dlcore=3D42,dev=3D0000:21:00.1-ch10,dir=3Dmem2mem
> +;lcore_dma27=3Dlcore=3D43,dev=3D0000:21:00.1-ch11,dir=3Dmem2mem
> +;lcore_dma28=3Dlcore=3D44,dev=3D0000:21:00.1-ch12,dir=3Dmem2mem
> +;lcore_dma29=3Dlcore=3D45,dev=3D0000:21:00.1-ch13,dir=3Dmem2mem
> +;lcore_dma30=3Dlcore=3D46,dev=3D0000:21:00.1-ch14,dir=3Dmem2mem
> +;lcore_dma31=3Dlcore=3D47,dev=3D0000:21:00.1-ch15,dir=3Dmem2mem
>  eal_args=3D--in-memory --file-prefix=3Dtest
> =20
> -[case2]
> -type=3DDMA_MEM_COPY
> -mem_size=3D10
> -buf_size=3D64,8192,2,MUL
> -dma_ring_size=3D1024
> -dma_src_sge=3D4
> -dma_dst_sge=3D1
> -kick_batch=3D32
> -src_numa_node=3D0
> -dst_numa_node=3D0
> -cache_flush=3D0
> -test_seconds=3D2
> -lcore_dma0=3Dlcore=3D10,dev=3D0000:00:04.1,dir=3Dmem2mem
> -lcore_dma1=3Dlcore=3D11,dev=3D0000:00:04.2,dir=3Dmem2mem
> -eal_args=3D--in-memory --file-prefix=3Dtest
> -
> -[case3]
> -skip=3D1
> -type=3DDMA_MEM_COPY
> -mem_size=3D10
> -buf_size=3D64,4096,2,MUL
> -dma_ring_size=3D1024
> -kick_batch=3D32
> -src_numa_node=3D0
> -dst_numa_node=3D0
> -cache_flush=3D0
> -test_seconds=3D2
> -lcore_dma0=3Dlcore=3D10,dev=3D0000:00:04.1,dir=3Dmem2mem
> -lcore_dma1=3Dlcore=3D11,dev=3D0000:00:04.2,dir=3Ddev2mem,raddr=3D0x20000=
0000,coreid=3D1,pfid=3D2,vfid=3D3
> -lcore_dma2=3Dlcore=3D12,dev=3D0000:00:04.3,dir=3Dmem2dev,raddr=3D0x30000=
0000,coreid=3D3,pfid=3D2,vfid=3D1
> -eal_args=3D--in-memory --file-prefix=3Dtest
> -
> -[case4]
> -type=3DCPU_MEM_COPY
> -mem_size=3D10
> -buf_size=3D64,8192,2,MUL
> -src_numa_node=3D0
> -dst_numa_node=3D1
> -cache_flush=3D0
> -test_seconds=3D2
> -lcore =3D 3, 4
> -eal_args=3D--in-memory --no-pci
> +;[case2]
> +;type=3DDMA_MEM_COPY
> +;mem_size=3D10
> +;buf_size=3D64,8192,2,MUL
> +;dma_ring_size=3D1024
> +;dma_src_sge=3D4
> +;dma_dst_sge=3D1
> +;kick_batch=3D32
> +;src_numa_node=3D0
> +;dst_numa_node=3D0
> +;cache_flush=3D0
> +;test_seconds=3D2
> +;lcore_dma0=3Dlcore=3D10,dev=3D0000:00:04.1,dir=3Dmem2mem
> +;lcore_dma1=3Dlcore=3D11,dev=3D0000:00:04.2,dir=3Dmem2mem
> +;eal_args=3D--in-memory --file-prefix=3Dtest
> +;
> +;[case3]
> +;skip=3D1
> +;type=3DDMA_MEM_COPY
> +;mem_size=3D10
> +;buf_size=3D64,4096,2,MUL
> +;dma_ring_size=3D1024
> +;kick_batch=3D32
> +;src_numa_node=3D0
> +;dst_numa_node=3D0
> +;cache_flush=3D0
> +;test_seconds=3D2
> +;lcore_dma0=3Dlcore=3D10,dev=3D0000:00:04.1,dir=3Dmem2mem
> +;lcore_dma1=3Dlcore=3D11,dev=3D0000:00:04.2,dir=3Ddev2mem,raddr=3D0x2000=
00000,coreid=3D1,pfid=3D2,vfid=3D3
> +;lcore_dma2=3Dlcore=3D12,dev=3D0000:00:04.3,dir=3Dmem2dev,raddr=3D0x3000=
00000,coreid=3D3,pfid=3D2,vfid=3D1
> +;eal_args=3D--in-memory --file-prefix=3Dtest
> +;
> +;[case4]
> +;type=3DCPU_MEM_COPY
> +;mem_size=3D10
> +;buf_size=3D64,8192,2,MUL
> +;src_numa_node=3D0
> +;dst_numa_node=3D1
> +;cache_flush=3D0
> +;test_seconds=3D2
> +;lcore =3D 3, 4
> +;eal_args=3D--in-memory --no-pci
> diff --git a/app/test-dma-perf/main.c b/app/test-dma-perf/main.c
> index 0586b3e1d0..1ecde6c236 100644
> --- a/app/test-dma-perf/main.c
> +++ b/app/test-dma-perf/main.c
> @@ -566,7 +566,6 @@ main(int argc, char *argv[])
>  		return -1;
>  	}
>  	fclose(fd);
> -
>  	printf("Running cases...\n");
>  	for (i =3D 0; i < case_nb; i++) {
>  		if (test_cases[i].is_skip) {
> @@ -644,7 +643,6 @@ main(int argc, char *argv[])
>  				printf("Case process unknown terminated.\n\n");
>  		}
>  	}
> -
>  	printf("Bye...\n");
>  	return 0;
>  }

Please don't do random whitespace changes like this.
Looks like you added printfs during testing, then removed them and left beh=
ind changes.

> diff --git a/app/test/test_dmadev.c b/app/test/test_dmadev.c
> index 143e1bcd68..73d854cc02 100644
> --- a/app/test/test_dmadev.c
> +++ b/app/test/test_dmadev.c
> @@ -4,6 +4,7 @@
>   */
> =20
>  #include <inttypes.h>
> +#include <rte_malloc.h>
> =20
>  #include <rte_dmadev.h>
>  #include <rte_mbuf.h>
> @@ -19,9 +20,9 @@
>  #define ERR_RETURN(...) do { print_err(__func__, __LINE__, __VA_ARGS__);=
 return -1; } while (0)
> =20
>  #define TEST_NAME_MAX_LEN 80
> -#define TEST_RINGSIZE 512
> +#define TEST_RINGSIZE 32
>  #define COPY_LEN 2048
> -
> +#define ALIGN_4K 4096
>  static struct rte_dma_info info;
>  static struct rte_mempool *pool;
>  static bool check_err_stats;
> @@ -135,8 +136,8 @@ do_multi_copies(int16_t dev_id, uint16_t vchan,
>  		int split_completions, /* gather 2 x 16 or 1 x 32 completions */
>  		int use_completed_status) /* use completed or completed_status functio=
n */
>  {
> -	struct rte_mbuf *srcs[32], *dsts[32];
> -	enum rte_dma_status_code sc[32];
> +	struct rte_mbuf *srcs[16], *dsts[16];
> +	enum rte_dma_status_code sc[16];
>  	unsigned int i, j;
>  	bool dma_err =3D false;
> =20
> @@ -159,6 +160,7 @@ do_multi_copies(int16_t dev_id, uint16_t vchan,
>  		if (rte_dma_copy(dev_id, vchan, rte_mbuf_data_iova(srcs[i]),
>  				 rte_mbuf_data_iova(dsts[i]), COPY_LEN, 0) !=3D id_count++)
>  			ERR_RETURN("Error with rte_dma_copy for buffer %u\n", i);
> +		id_count %=3D 32;
>  	}
>  	rte_dma_submit(dev_id, vchan);
> =20
> @@ -228,15 +230,13 @@ test_single_copy(int16_t dev_id, uint16_t vchan)
>  	enum rte_dma_status_code status;
>  	struct rte_mbuf *src, *dst;
>  	char *src_data, *dst_data;
> -
>  	src =3D rte_pktmbuf_alloc(pool);
>  	dst =3D rte_pktmbuf_alloc(pool);
> +
>  	src_data =3D rte_pktmbuf_mtod(src, char *);
>  	dst_data =3D rte_pktmbuf_mtod(dst, char *);
> -
>  	for (i =3D 0; i < COPY_LEN; i++)
>  		src_data[i] =3D rte_rand() & 0xFF;
> -
>  	id =3D rte_dma_copy(dev_id, vchan, rte_pktmbuf_iova(src), rte_pktmbuf_i=
ova(dst),
>  			COPY_LEN, RTE_DMA_OP_FLAG_SUBMIT);
>  	if (id !=3D id_count)
> @@ -284,7 +284,7 @@ test_single_copy(int16_t dev_id, uint16_t vchan)
>  		ERR_RETURN("Error with rte_dma_completed in empty check\n");
> =20
>  	id_count++;
> -
> +	id_count %=3D 32;
>  	return 0;
>  }
> =20
> @@ -296,15 +296,13 @@ test_enqueue_copies(int16_t dev_id, uint16_t vchan)
>  	/* test doing a single copy */
>  	if (test_single_copy(dev_id, vchan) < 0)
>  		return -1;
> -
>  	/* test doing a multiple single copies */
>  	do {
>  		uint16_t id;
> -		const uint16_t max_ops =3D 4;
> +		const uint16_t max_ops =3D 28;
>  		struct rte_mbuf *src, *dst;
>  		char *src_data, *dst_data;
>  		uint16_t count;
> -
>  		src =3D rte_pktmbuf_alloc(pool);
>  		dst =3D rte_pktmbuf_alloc(pool);
>  		src_data =3D rte_pktmbuf_mtod(src, char *);
> @@ -314,13 +312,14 @@ test_enqueue_copies(int16_t dev_id, uint16_t vchan)
>  			src_data[i] =3D rte_rand() & 0xFF;
> =20
>  		/* perform the same copy <max_ops> times */
> -		for (i =3D 0; i < max_ops; i++)
> +		for (i =3D 0; i < max_ops; i++) {
>  			if (rte_dma_copy(dev_id, vchan,
> -					rte_pktmbuf_iova(src),
> -					rte_pktmbuf_iova(dst),
> -					COPY_LEN, RTE_DMA_OP_FLAG_SUBMIT) !=3D id_count++)
> +						rte_pktmbuf_iova(src),
> +						rte_pktmbuf_iova(dst),
> +						COPY_LEN, RTE_DMA_OP_FLAG_SUBMIT) !=3D id_count++)
>  				ERR_RETURN("Error with rte_dma_copy\n");
> -
> +			id_count %=3D 32;
> +		}
>  		await_hw(dev_id, vchan);
> =20
>  		count =3D rte_dma_completed(dev_id, vchan, max_ops * 2, &id, NULL);
> @@ -328,7 +327,7 @@ test_enqueue_copies(int16_t dev_id, uint16_t vchan)
>  			ERR_RETURN("Error with rte_dma_completed, got %u not %u\n",
>  					count, max_ops);
> =20
> -		if (id !=3D id_count - 1)
> +		if (id !=3D (id_count - 1 + 32) % 32)
>  			ERR_RETURN("Error, incorrect job id returned: got %u not %u\n",
>  					id, id_count - 1);
> =20
> @@ -339,8 +338,8 @@ test_enqueue_copies(int16_t dev_id, uint16_t vchan)
>  		rte_pktmbuf_free(src);
>  		rte_pktmbuf_free(dst);
>  	} while (0);
> -
>  	/* test doing multiple copies */
> +	return 0;
>  	return do_multi_copies(dev_id, vchan, 0, 0, 0) /* enqueue and complete =
1 batch at a time */
>  			/* enqueue 2 batches and then complete both */
>  			|| do_multi_copies(dev_id, vchan, 1, 0, 0)
> @@ -1161,7 +1160,7 @@ test_dmadev_setup(void)
>  	if (rte_dma_stats_get(dev_id, vchan, &stats) !=3D 0)
>  		ERR_RETURN("Error with rte_dma_stats_get()\n");
> =20
> -	if (rte_dma_burst_capacity(dev_id, vchan) < 32)
> +	if (rte_dma_burst_capacity(dev_id, vchan) < 2)
>  		ERR_RETURN("Error: Device does not have sufficient burst capacity to r=
un tests");
> =20
>  	if (stats.completed !=3D 0 || stats.submitted !=3D 0 || stats.errors !=
=3D 0)
> @@ -1211,7 +1210,7 @@ test_dmadev_instance(int16_t dev_id)
>  	};
> =20
>  	static struct runtest_param param[] =3D {
> -		{"copy", test_enqueue_copies, 640},
> +		{"copy", test_enqueue_copies, 10000},
>  		{"sg_copy", test_enqueue_sg_copies, 1},
>  		{"stop_start", test_stop_start, 1},
>  		{"burst_capacity", test_burst_capacity, 1},
> @@ -1317,13 +1316,9 @@ test_dma(void)
>  		return TEST_SKIPPED;
> =20
>  	RTE_DMA_FOREACH_DEV(i) {
> -		if (test_dma_api(i) < 0)
> -			ERR_RETURN("Error performing API tests\n");
> -
>  		if (test_dmadev_instance(i) < 0)
>  			ERR_RETURN("Error, test failure for device %d\n", i);
>  	}
> -
>  	return 0;
>  }
> =20
> diff --git a/drivers/dma/ae4dma/ae4dma_dmadev.c b/drivers/dma/ae4dma/ae4d=
ma_dmadev.c
> new file mode 100644
> index 0000000000..de9f87ec79
> --- /dev/null
> +++ b/drivers/dma/ae4dma/ae4dma_dmadev.c
> @@ -0,0 +1,656 @@
> +/* SPDX-License-Identifier: BSD-3.0-Clause
> + * Copyright(c) 2021 Advanced Micro Devices, Inc. All rights reserved.
> + */
> +
> +#include <rte_bus_pci.h>
> +#include <bus_pci_driver.h>
> +#include <rte_dmadev_pmd.h>
> +#include <rte_malloc.h>
> +#include <rte_prefetch.h>
> +#include <rte_errno.h>
> +
> +#include "ae4dma_internal.h"
> +
> +#define MAX_RETRY 10
> +#define hwq_id 0
> +
> +static struct rte_pci_driver ae4dma_pmd_drv;
> +
> +RTE_LOG_REGISTER_DEFAULT(ae4dma_pmd_logtype, INFO);
> +
> +static int ae4dma_dev_dump(const struct rte_dma_dev *dev, FILE *f);
> +static int ae4dma_add_queue(struct ae4dma_dmadev *dev, uint8_t qn);
> +
> +#define DESC_SZ sizeof(struct ae4dma_dma_hw_desc)
> +
> +#define AE4DMA_PMD_NAME dmadev_ae4dma
> +#define AE4DMA_PMD_NAME_STR RTE_STR(AE4DMA_PMD_NAME)
> +
> +/* AE4DMA operations. */
> +enum rte_ae4dma_ops {
> +	ae4dma_op_copy =3D 0,	/* Standard DMA Operation */
> +	ae4dma_op_fill		/* Block Fill */
> +};
> +
> +static const struct rte_memzone *
> +ae4dma_queue_dma_zone_reserve(const char *queue_name,
> +		uint32_t queue_size, int socket_id)
> +{
> +	const struct rte_memzone *mz;
> +	mz =3D rte_memzone_lookup(queue_name);
> +	if (mz !=3D 0) {
> +		if (((size_t)queue_size <=3D mz->len) &&
> +				((socket_id =3D=3D SOCKET_ID_ANY) ||
> +				 (socket_id =3D=3D mz->socket_id))) {
> +			AE4DMA_PMD_INFO("re-use memzone already "
> +					"allocated for %s", queue_name);
> +			return mz;
> +		}
> +		AE4DMA_PMD_ERR("Incompatible memzone already "
> +				"allocated %s, size %u, socket %d. "
> +				"Requested size %u, socket %u",
> +				queue_name, (uint32_t)mz->len,
> +				mz->socket_id, queue_size, socket_id);
> +		return NULL;
> +	}
> +	return rte_memzone_reserve_aligned(queue_name, queue_size,
> +			socket_id, RTE_MEMZONE_IOVA_CONTIG, queue_size);
> +}
> +
> +/* Configure a device. */
> +static int
> +ae4dma_dev_configure(struct rte_dma_dev *dev __rte_unused, const struct =
rte_dma_conf *dev_conf,
> +		uint32_t conf_sz)
> +{
> +	if (sizeof(struct rte_dma_conf) !=3D conf_sz)
> +		return -EINVAL;
> +
> +	if (dev_conf->nb_vchans !=3D 1)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +/* Setup a virtual channel for AE4DMA, only 1 vchan is supported. */
> +static int
> +ae4dma_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan __rte_unused,
> +		const struct rte_dma_vchan_conf *qconf, uint32_t qconf_sz)
> +{
> +	struct ae4dma_dmadev *ae4dma =3D dev->fp_obj->dev_private;
> +	uint16_t max_desc =3D qconf->nb_desc;
> +
> +	struct ae4dma_cmd_queue *cmd_q =3D &ae4dma->cmd_q[hwq_id];
> +
> +	if (sizeof(struct rte_dma_vchan_conf) !=3D qconf_sz)
> +		return -EINVAL;
> +
> +	cmd_q->qcfg =3D *qconf;
> +
> +	if (!rte_is_power_of_2(max_desc)) {
> +		max_desc =3D rte_align32pow2(max_desc);
> +		printf("DMA dev %u using %u descriptors\n", dev->data->dev_id, max_des=
c);
> +		AE4DMA_PMD_DEBUG("DMA dev %u using %u descriptors", dev->data->dev_id,=
 max_desc);
> +		cmd_q->qcfg.nb_desc =3D max_desc;
> +	}
> +	/* Ensure all counters are reset, if reconfiguring/restarting device. R=
eset Stats*/
> +	memset(&cmd_q->stats, 0, sizeof(cmd_q->stats));
> +	return 0;
> +}
> +
> +
> +/* Start a configured device. */
> +static int
> +ae4dma_dev_start(struct rte_dma_dev *dev)
> +{
> +	struct ae4dma_dmadev *ae4dma =3D dev->fp_obj->dev_private;
> +	struct ae4dma_cmd_queue *cmd_q =3D &ae4dma->cmd_q[hwq_id];
> +
> +	if (cmd_q->qcfg.nb_desc =3D=3D 0)
> +		return -EBUSY;
> +	return 0;
> +}
> +
> +/* Stop a configured device. */
> +static int
> +ae4dma_dev_stop(struct rte_dma_dev *dev)
> +{
> +	struct ae4dma_dmadev *ae4dma =3D dev->fp_obj->dev_private;
> +	struct ae4dma_cmd_queue *cmd_q =3D &ae4dma->cmd_q[hwq_id];
> +	if (cmd_q->qcfg.nb_desc =3D=3D 0)
> +		return -EBUSY;
> +	return 0;
> +}
> +
> +/* Get device information of a device. */
> +static int
> +ae4dma_dev_info_get(const struct rte_dma_dev *dev, struct rte_dma_info *=
info, uint32_t size)
> +{
> +
> +	if (size < sizeof(*info))
> +		return -EINVAL;
> +	info->dev_name =3D dev->device->name;
> +	info->dev_capa =3D RTE_DMA_CAPA_MEM_TO_MEM;
> +	info->max_vchans =3D 1;
> +	info->min_desc =3D 2;
> +	info->max_desc =3D 32;
> +	info->nb_vchans =3D 1;
> +	return 0;
> +}
> +
> +/* Close a configured device. */
> +static int
> +ae4dma_dev_close(struct rte_dma_dev *dev)
> +{
> +	RTE_SET_USED(dev);
> +	return 0;
> +}
> +
> +/* trigger h/w to process enqued desc:doorbell - by next_write */
> +static inline void
> +__submit(struct ae4dma_dmadev *ae4dma)


Don't use __ prefix, it looks like a compiler builtin not a function.

> +{
> +	struct ae4dma_cmd_queue *cmd_q =3D &ae4dma->cmd_q[hwq_id];
> +	volatile uint16_t  write_idx =3D cmd_q->next_write;
> +	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->write_idx, write_idx);
> +	cmd_q->stats.submitted +=3D (uint16_t)(cmd_q->next_write - cmd_q->last_=
write +
> +			AE4DMA_DESCRITPTORS_PER_CMDQ) % AE4DMA_DESCRITPTORS_PER_CMDQ;
> +	cmd_q->last_write =3D cmd_q->next_write;
> +}
> +
> +/* External submit function wrapper. */
> +
> +static int
> +ae4dma_submit(void *dev_private, uint16_t qid __rte_unused)
> +{
> +
> +	struct ae4dma_dmadev *ae4dma =3D dev_private;
> +
> +	__submit(ae4dma);
> +
> +	return 0;
> +}
> +
> +/* Write descriptor for enqueue. */
> +
> +static inline int
> +__write_desc(void *dev_private, uint32_t op, uint64_t src, phys_addr_t d=
st,
> +		unsigned int len, uint64_t flags)
> +{
> +	struct ae4dma_dmadev *ae4dma =3D dev_private;
> +	struct ae4dma_cmd_queue *cmd_q =3D &ae4dma->cmd_q[hwq_id];
> +	struct ae4dma_desc *dma_desc;
> +	uint16_t ret;
> +	const uint16_t mask =3D cmd_q->qcfg.nb_desc - 1;
> +	const uint16_t read =3D cmd_q->next_read;
> +	uint16_t write =3D cmd_q->next_write;
> +	const uint16_t space =3D mask + read - write;
> +
> +	if (cmd_q->ring_buff_count >=3D 28) {
> +		AE4DMA_PMD_DEBUG("NO SPACE : ring_buff_count : %d\n", cmd_q->ring_buff=
_count);
> +		return -ENOSPC;
> +	}
> +	if (op)
> +		AE4DMA_PMD_WARN("FILL not supported:performing COPY\n");
> +	dma_desc =3D &ae4dma->cmd_q[hwq_id].qbase_desc[write];
> +	dma_desc->dw0.byte0 =3D 0;
> +	dma_desc->dw1.status =3D 0;
> +	dma_desc->dw1.err_code =3D 0;
> +	dma_desc->dw1.desc_id  =3D 0;
> +	dma_desc->length =3D len;
> +	dma_desc->src_hi =3D upper_32_bits(src);
> +	dma_desc->src_lo =3D lower_32_bits(src);
> +	dma_desc->dst_hi =3D upper_32_bits(dst);
> +	dma_desc->dst_lo =3D lower_32_bits(dst);
> +	cmd_q->ring_buff_count++;
> +	cmd_q->next_write =3D (write + 1) % (AE4DMA_DESCRITPTORS_PER_CMDQ);
> +	ret =3D write;
> +	if (flags & RTE_DMA_OP_FLAG_SUBMIT)
> +		__submit(ae4dma);
> +	return ret;
> +}
> +
> +/* Enqueue a fill operation onto the ae4dma device. */
> +static int
> +ae4dma_enqueue_fill(void *dev_private, uint16_t qid __rte_unused, uint64=
_t pattern,
> +		rte_iova_t dst, unsigned int length, uint64_t flags)
> +{
> +	return __write_desc(dev_private, ae4dma_op_fill, pattern, dst, length, =
flags);
> +}
> +
> +/* Enqueue a copy operation onto the ae4dma device. */
> +static int
> +ae4dma_enqueue_copy(void *dev_private, uint16_t qid __rte_unused, rte_io=
va_t src,
> +		rte_iova_t dst, unsigned int length, uint64_t flags)
> +{
> +	return __write_desc(dev_private, ae4dma_op_copy, src, dst, length, flag=
s);
> +}
> +
> +/* Dump DMA device info. */
> +static int
> +ae4dma_dev_dump(const struct rte_dma_dev *dev, FILE *f)
> +{
> +	struct ae4dma_dmadev *ae4dma =3D dev->fp_obj->dev_private;
> +	struct ae4dma_cmd_queue *cmd_q;
> +	void *ae4dma_mmio_base_addr =3D (uint8_t *) ae4dma->io_regs;
> +
> +	cmd_q =3D &ae4dma->cmd_q[hwq_id];
> +	fprintf(f, "cmd_q->id              =3D %" PRIx64 "\n", cmd_q->id);
> +	fprintf(f, "cmd_q->qidx            =3D %" PRIx64 "\n", cmd_q->qidx);
> +	fprintf(f, "cmd_q->qsize           =3D %" PRIx64 "\n", cmd_q->qsize);
> +	fprintf(f, "mmio_base_addr	=3D %p\n", ae4dma_mmio_base_addr);
> +	fprintf(f, "queues per ae4dma engine     =3D %d\n", AE4DMA_READ_REG_OFF=
SET(
> +				ae4dma_mmio_base_addr, AE4DMA_COMMON_CONFIG_OFFSET));
> +	fprintf(f, "=3D=3D Private Data =3D=3D\n");
> +	fprintf(f, "  Config: { ring_size: %u }\n", cmd_q->qcfg.nb_desc);
> +	fprintf(f, "  Ring IOVA: %#lx\t%#lx\t%#lx\n", cmd_q->qbase_desc, cmd_q-=
>qbase_addr,
> +			cmd_q->qbase_phys_addr);
> +	fprintf(f, "  Next write: %u\n", cmd_q->next_write);
> +	fprintf(f, "  Next read: %u\n", cmd_q->next_read);
> +	fprintf(f, "  current queue depth: %u\n", cmd_q->ring_buff_count);
> +	fprintf(f, "  }\n");
> +	fprintf(f, "  Key Stats { submitted: %"PRIu64", comp: %"PRIu64", failed=
: %"PRIu64" }\n",
> +		cmd_q->stats.submitted,
> +		cmd_q->stats.completed,
> +		cmd_q->stats.errors);
> +	return 0;
> +}
> +
> +/* Translates AE4DMA ChanERRs to DMA error codes. */
> +static inline enum rte_dma_status_code
> +__translate_status_ae4dma_to_dma(enum ae4dma_dma_err status)
> +{
> +	AE4DMA_PMD_INFO("ae4dma desc status =3D %d\n", status);
> +	/*
> +	 * to be modified for proper error mapping of ae4dma
> +	 */
> +
> +	switch (status) {
> +	case AE4DMA_DMA_ERR_NO_ERR:
> +		return RTE_DMA_STATUS_SUCCESSFUL;
> +	case AE4DMA_DMA_ERR_INV_LEN:
> +		return RTE_DMA_STATUS_INVALID_LENGTH;
> +	case AE4DMA_DMA_ERR_INV_SRC:
> +		return RTE_DMA_STATUS_INVALID_SRC_ADDR;
> +	case AE4DMA_DMA_ERR_INV_DST:
> +		return RTE_DMA_STATUS_INVALID_DST_ADDR;
> +	case AE4DMA_DMA_ERR_INV_ALIGN:
> +		return RTE_DMA_STATUS_DATA_POISION;
> +	case AE4DMA_DMA_ERR_INV_HEADER:
> +	case AE4DMA_DMA_ERR_INV_STATUS:
> +		return RTE_DMA_STATUS_ERROR_UNKNOWN;
> +	default:
> +		return RTE_DMA_STATUS_ERROR_UNKNOWN;
> +
> +	}
> +	return 0;
> +}
> +
> +/*
> + * icans h/w queues for descriptor processed status	returns total proces=
sed count of descriptor
> + *@param cmd_q
> + *@param maximum ops expected
> + *the ae4dma h/w queue info  struct
> + *@param[out] failed_count
> + *   transfer error count
> + * @return
> + *   The  number of operations that  completed - both success and failes
> + */
> +static inline uint16_t
> +ae4dma_scan_hwq(struct ae4dma_cmd_queue *cmd_q, const uint16_t max_ops, =
uint16_t *failed_count)
> +{
> +	volatile struct ae4dma_desc *hw_desc;
> +	uint32_t events_count =3D 0, fails =3D 0;
> +	volatile uint32_t tail;
> +	volatile uint32_t desc_status;
> +	uint32_t retry_count =3D MAX_RETRY;
> +	uint32_t sub_desc_cnt;
> +	tail =3D cmd_q->next_read;
> +	/* process all the submitted descriptors for the HW queue */
> +	sub_desc_cnt =3D cmd_q->ring_buff_count;
> +	if (max_ops < sub_desc_cnt)
> +		sub_desc_cnt =3D max_ops;
> +	while (sub_desc_cnt) {
> +		desc_status =3D 0;
> +		retry_count =3D MAX_RETRY;
> +		do {
> +			hw_desc =3D &cmd_q->qbase_desc[tail];
> +			desc_status =3D hw_desc->dw1.status;
> +			if (desc_status) {
> +				if (desc_status !=3D AE4DMA_DMA_DESC_COMPLETED) {
> +					fails++;
> +					AE4DMA_PMD_WARN("WARNING:Desc error code : %d\n",
> +							hw_desc->dw1.err_code);
> +				}
> +				if (cmd_q->ring_buff_count)
> +					cmd_q->ring_buff_count--;
> +				cmd_q->status[events_count] =3D hw_desc->dw1.err_code;
> +				events_count++;
> +				tail =3D (tail + 1) % AE4DMA_DESCRITPTORS_PER_CMDQ;
> +				sub_desc_cnt--;
> +			}
> +		} while (!desc_status && retry_count--);
> +		if (desc_status =3D=3D 0)
> +			break;
> +	}
> +	cmd_q->stats.completed +=3D events_count;
> +	cmd_q->stats.errors +=3D fails;
> +	cmd_q->next_read =3D tail;
> +	*failed_count =3D fails;
> +	return events_count;
> +}
> +
> +/* Returns successful operations count and sets error flag if any errors=
. */
> +static uint16_t
> +ae4dma_completed(void *dev_private, uint16_t qid __rte_unused, const uin=
t16_t max_ops,
> +		uint16_t *last_idx, bool *has_error)
> +{
> +
> +	struct ae4dma_dmadev *ae4dma =3D  dev_private;
> +	struct ae4dma_cmd_queue *cmd_q =3D &ae4dma->cmd_q[hwq_id];
> +	const uint16_t read =3D cmd_q->next_read;
> +	uint16_t   cpl_count, sl_count;
> +	*has_error =3D false;
> +	uint16_t err_count =3D 0;
> +
> +	cpl_count =3D ae4dma_scan_hwq(cmd_q, max_ops, &err_count);
> +
> +	if (cpl_count > max_ops)
> +		cpl_count =3D max_ops;
> +	if (cpl_count <=3D max_ops)
> +		*last_idx =3D (cmd_q->next_read - 1 + AE4DMA_DESCRITPTORS_PER_CMDQ) %
> +			AE4DMA_DESCRITPTORS_PER_CMDQ;
> +
> +	sl_count =3D cpl_count - err_count;
> +	if (err_count)
> +		*has_error =3D true;
> +
> +	return sl_count;
> +}
> +
> +/* Returns detailed status information about operations that have been c=
ompleted. */
> +
> +static uint16_t
> +ae4dma_completed_status(void *dev_private, uint16_t qid __rte_unused,
> +		uint16_t max_ops, uint16_t *last_idx, enum rte_dma_status_code *status)
> +
> +{
> +	struct ae4dma_dmadev *ae4dma =3D  dev_private;
> +	struct ae4dma_cmd_queue *cmd_q =3D &ae4dma->cmd_q[hwq_id];
> +	const uint16_t read =3D cmd_q->next_read;
> +	uint16_t   cpl_count;
> +	uint16_t   i;
> +	uint16_t err_count =3D 0;
> +
> +	cpl_count =3D ae4dma_scan_hwq(cmd_q, max_ops, &err_count);
> +
> +	if (cpl_count > max_ops)
> +		cpl_count =3D max_ops;
> +	if (cpl_count <=3D max_ops)
> +		*last_idx =3D (cmd_q->next_read-1+AE4DMA_DESCRITPTORS_PER_CMDQ) %
> +			AE4DMA_DESCRITPTORS_PER_CMDQ;
> +	if (likely(!err_count)) {
> +		for (i =3D 0; i < cpl_count; i++)
> +			status[i] =3D RTE_DMA_STATUS_SUCCESSFUL;
> +	}
> +	if (unlikely(err_count >=3D 1)) {
> +		for (i =3D 0; i < cpl_count; i++)
> +			status[i] =3D __translate_status_ae4dma_to_dma(cmd_q->status[i]);
> +	}
> +
> +	return cpl_count;
> +}
> +
> +/* Get the remaining capacity of the ring. */
> +static uint16_t
> +ae4dma_burst_capacity(const void *dev_private, uint16_t vchan __rte_unus=
ed)
> +
> +{
> +	const struct ae4dma_dmadev *ae4dma =3D dev_private;
> +	struct ae4dma_cmd_queue *cmd_q =3D &ae4dma->cmd_q[hwq_id];
> +	unsigned short size =3D cmd_q->qcfg.nb_desc - 1;
> +	unsigned short read =3D cmd_q->next_read;
> +	unsigned short write =3D cmd_q->next_write;
> +	unsigned short space =3D size - (write - read);
> +
> +	return space;
> +}
> +
> +/* Retrieve the generic stats of a DMA device. */
> +static int
> +ae4dma_stats_get(const struct rte_dma_dev *dev, uint16_t vchan __rte_unu=
sed,
> +		struct rte_dma_stats *rte_stats, uint32_t size)
> +{
> +	const struct ae4dma_dmadev *ae4dma =3D dev->fp_obj->dev_private;
> +	struct ae4dma_cmd_queue *cmd_q =3D &ae4dma->cmd_q[hwq_id];
> +	struct rte_dma_stats *stats =3D &cmd_q->stats;
> +	if (size < sizeof(rte_stats))
> +		return -EINVAL;
> +	if (rte_stats =3D=3D NULL)
> +		return -EINVAL;
> +
> +	*rte_stats =3D *stats;
> +	return 0;
> +}
> +
> +/* Reset the generic stat counters for the DMA device. */
> +static int
> +ae4dma_stats_reset(struct rte_dma_dev *dev, uint16_t vchan __rte_unused)
> +{
> +	struct ae4dma_dmadev *ae4dma =3D dev->fp_obj->dev_private;
> +	struct ae4dma_cmd_queue *cmd_q =3D &ae4dma->cmd_q[hwq_id];
> +
> +	memset(&cmd_q->stats, 0, sizeof(cmd_q->stats));
> +	return 0;
> +}
> +
> +/* Check if the AE4DMA device is idle. */
> +static int
> +ae4dma_vchan_status(const struct rte_dma_dev *dev, uint16_t vchan __rte_=
unused,
> +		enum rte_dma_vchan_status *status)
> +{
> +	struct ae4dma_dmadev *ae4dma =3D dev->fp_obj->dev_private;
> +	struct ae4dma_cmd_queue *cmd_q;
> +	uint32_t cmd_q_ctrl;
> +
> +	cmd_q =3D &ae4dma->cmd_q[0];
> +/*
> + * As of now returning -1, as this functionality is not
> + * supported by ae4dma and it's valid also as this status
> + * callback implemetaion by driver is optional.
> + */
> +	return -1;
> +}
> +
> +int
> +ae4dma_add_queue(struct ae4dma_dmadev *dev, uint8_t qn)
> +{
> +	uint32_t dma_addr_lo, dma_addr_hi;
> +	uint32_t q_per_eng =3D 0;
> +	struct ae4dma_cmd_queue *cmd_q;
> +	const struct rte_memzone *q_mz;
> +	void *ae4dma_mmio_base_addr;
> +	int i;
> +	static int dev_id;
> +	if (dev =3D=3D NULL)
> +		return -1;
> +	dev->qidx =3D 0;
> +	q_per_eng =3D AE4DMA_MAX_HW_QUEUES;
> +	dev->io_regs =3D (void *)(dev->pci.mem_resource[AE4DMA_PCIE_BAR].addr);
> +	ae4dma_mmio_base_addr =3D (uint8_t *) dev->io_regs;
> +	/* Set the number of HW queues for this AE4DMA engine */
> +	AE4DMA_WRITE_REG_OFFSET(ae4dma_mmio_base_addr, AE4DMA_COMMON_CONFIG_OFF=
SET, q_per_eng);
> +	q_per_eng =3D AE4DMA_READ_REG_OFFSET(ae4dma_mmio_base_addr, AE4DMA_COMM=
ON_CONFIG_OFFSET);
> +	AE4DMA_PMD_INFO("AE4DMA queues per engine =3D %d\n", q_per_eng);
> +
> +	dev->id =3D dev_id++;
> +	dev->cmd_q_count =3D 0;
> +	i =3D qn;
> +	/* Find available queues */
> +	cmd_q =3D &dev->cmd_q[dev->cmd_q_count++];
> +	cmd_q->id =3D i;
> +	cmd_q->qidx =3D 0;
> +	/* Queue_size: 32*sizeof(struct ae4dmadma_desc) */
> +	cmd_q->qsize =3D AE4DMA_QUEUE_SIZE(AE4DMA_QUEUE_DESC_SIZE);
> +	cmd_q->hwq_regs =3D (volatile struct ae4dma_hwq_regs *)dev->io_regs + (=
i + 1);
> +	/* AE4DMA queue memory */
> +	snprintf(cmd_q->memz_name, sizeof(cmd_q->memz_name),
> +			"%s_%d_%s_%d_%s",
> +			"ae4dma_dev",
> +			(int)dev->id, "queue",
> +			(int)cmd_q->id, "mem");
> +	q_mz =3D ae4dma_queue_dma_zone_reserve(cmd_q->memz_name,
> +			cmd_q->qsize, rte_socket_id());
> +	cmd_q->qbase_addr =3D (void *)q_mz->addr;
> +	cmd_q->qbase_desc =3D (void *)q_mz->addr;
> +	cmd_q->qbase_phys_addr =3D  q_mz->iova;
> +	/* Max Index (cmd queue length) */
> +	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->max_idx, AE4DMA_DESCRITPTORS_PER_CMD=
Q);
> +	/* Queue Enable */
> +	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->control_reg.control_raw, AE4DMA_CMD_=
QUEUE_ENABLE);
> +	/* Disabling the interrupt */
> +	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->intr_status_reg.intr_status_raw, AE4=
DMA_DISABLE_INTR);
> +	cmd_q->next_write =3D AE4DMA_READ_REG(&cmd_q->hwq_regs->write_idx);
> +	cmd_q->next_read =3D AE4DMA_READ_REG(&cmd_q->hwq_regs->read_idx);
> +	cmd_q->ring_buff_count =3D 0;
> +	/* Update the device registers with queue addresses */
> +	dma_addr_lo =3D low32_value(cmd_q->qbase_phys_addr);
> +	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->qbase_lo,
> +			(uint32_t)dma_addr_lo);
> +	dma_addr_hi =3D high32_value(cmd_q->qbase_phys_addr);
> +	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->qbase_hi,
> +			(uint32_t)dma_addr_hi);
> +	if (dev->cmd_q_count =3D=3D 0) {
> +		AE4DMA_PMD_ERR("Error in enabling HW queues.No HW queues available\n");
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +/* Create a dmadev(dpdk DMA device) */
> +static int
> +ae4dma_dmadev_create(const char *name, struct rte_pci_device *dev, uint8=
_t qn)
> +{
> +	static const struct rte_dma_dev_ops ae4dma_dmadev_ops =3D {
> +		.dev_close =3D ae4dma_dev_close,
> +		.dev_configure =3D ae4dma_dev_configure,
> +		.dev_dump =3D ae4dma_dev_dump,
> +		.dev_info_get =3D ae4dma_dev_info_get,
> +		.dev_start =3D ae4dma_dev_start,
> +		.dev_stop =3D ae4dma_dev_stop,
> +		.stats_get =3D ae4dma_stats_get,
> +		.stats_reset =3D ae4dma_stats_reset,
> +		.vchan_status =3D ae4dma_vchan_status,
> +		.vchan_setup =3D ae4dma_vchan_setup,
> +	};
> +
> +	struct rte_dma_dev *dmadev =3D NULL;
> +	struct ae4dma_dmadev *ae4dma =3D NULL;
> +	char hwq_dev_name[RTE_DEV_NAME_MAX_LEN];
> +
> +	if (!name) {
> +		AE4DMA_PMD_ERR("Invalid name of the device!");
> +		return -EINVAL;
> +	}
> +	memset(hwq_dev_name, 0, sizeof(hwq_dev_name));
> +	(void) snprintf(hwq_dev_name, sizeof(hwq_dev_name), "%s-ch%u", name, qn=
);
> +
> +	/* Allocate device structure. */
> +	dmadev =3D rte_dma_pmd_allocate(hwq_dev_name, dev->device.numa_node,
> +			sizeof(struct ae4dma_dmadev));
> +	if (dmadev =3D=3D NULL) {
> +		AE4DMA_PMD_ERR("Unable to allocate dma device");
> +		return -ENOMEM;
> +	}
> +	dmadev->device =3D &dev->device;
> +	dmadev->fp_obj->dev_private =3D dmadev->data->dev_private;
> +	dmadev->dev_ops =3D &ae4dma_dmadev_ops;
> +
> +	dmadev->fp_obj->burst_capacity =3D ae4dma_burst_capacity;
> +	dmadev->fp_obj->completed =3D ae4dma_completed;
> +	dmadev->fp_obj->completed_status =3D ae4dma_completed_status;
> +	dmadev->fp_obj->copy =3D ae4dma_enqueue_copy;
> +	dmadev->fp_obj->fill =3D ae4dma_enqueue_fill;
> +	dmadev->fp_obj->submit =3D ae4dma_submit;
> +
> +	ae4dma =3D dmadev->data->dev_private;
> +	ae4dma->dmadev =3D dmadev;
> +	/* ae4dma->qcfg.nb_desc =3D 0; */
> +	ae4dma->pci =3D *dev;
> +	/* ae4dma->io_regs =3D (void *)(dev->mem_resource[AE4DMA_PCIE_BAR].addr=
); */
> +	/* device is valid, add queue details */
> +	if (ae4dma_add_queue(ae4dma, qn))
> +		goto init_error;
> +	return 0;
> +
> +init_error:
> +	AE4DMA_PMD_ERR("driver %s(): failed", __func__);
> +	return -EFAULT;
> +}
> +
> +/* Destroy a DMA device. */
> +static int
> +ae4dma_dmadev_destroy(const char *name)
> +{
> +	int ret;
> +
> +	if (!name) {
> +		AE4DMA_PMD_ERR("Invalid device name");
> +		return -EINVAL;
> +	}
> +
> +	ret =3D rte_dma_pmd_release(name);
> +	if (ret)
> +		AE4DMA_PMD_DEBUG("Device cleanup failed");
> +
> +	return 0;
> +}
> +
> +/* Probe DMA device. */
> +static int
> +ae4dma_dmadev_probe(struct rte_pci_driver *drv, struct rte_pci_device *d=
ev)
> +{
> +	char name[32];
> +	int ret;
> +	rte_pci_device_name(&dev->addr, name, sizeof(name));
> +	AE4DMA_PMD_INFO("Init %s on NUMA node %d", name, dev->device.numa_node);
> +	dev->device.driver =3D &drv->driver;
> +	for (uint8_t i =3D 0; i < AE4DMA_MAX_HW_QUEUES; i++) {
> +		ret =3D ae4dma_dmadev_create(name, dev, i);
> +		if (ret) {
> +			AE4DMA_PMD_ERR("%s create dmadev %u failed!",
> +					name, i);
> +			break;
> +		}
> +	}
> +	return ret;
> +}
> +
> +/* Remove DMA device. */
> +static int
> +ae4dma_dmadev_remove(struct rte_pci_device *dev)
> +{
> +	char name[32];
> +
> +	rte_pci_device_name(&dev->addr, name, sizeof(name));
> +
> +	AE4DMA_PMD_INFO("Closing %s on NUMA node %d",
> +			name, dev->device.numa_node);
> +
> +	return ae4dma_dmadev_destroy(name);
> +}
> +
> +static const struct rte_pci_id pci_id_ae4dma_map[] =3D {
> +	{ RTE_PCI_DEVICE(AMD_VENDOR_ID, AE4DMA_DEVICE_ID) },
> +	{ .vendor_id =3D 0, /* sentinel */ },
> +};
> +
> +static struct rte_pci_driver ae4dma_pmd_drv =3D {
> +	.id_table =3D pci_id_ae4dma_map,
> +	.drv_flags =3D RTE_PCI_DRV_NEED_MAPPING | RTE_PCI_DRV_INTR_LSC,
> +	.probe =3D ae4dma_dmadev_probe,
> +	.remove =3D ae4dma_dmadev_remove,
> +};
> +
> +RTE_PMD_REGISTER_PCI(AE4DMA_PMD_NAME, ae4dma_pmd_drv);
> +RTE_PMD_REGISTER_PCI_TABLE(AE4DMA_PMD_NAME, pci_id_ae4dma_map);
> +RTE_PMD_REGISTER_KMOD_DEP(AE4DMA_PMD_NAME, "* igb_uio | uio_pci_generic =
| vfio-pci");
> diff --git a/drivers/dma/ae4dma/ae4dma_hw_defs.h b/drivers/dma/ae4dma/ae4=
dma_hw_defs.h
> new file mode 100644
> index 0000000000..c9ce935c94
> --- /dev/null
> +++ b/drivers/dma/ae4dma/ae4dma_hw_defs.h
> @@ -0,0 +1,225 @@
> +/* SPDX-License-Identifier: BSD-3.0-Clause
> + * Copyright(c) 2024 Advanced Micro Devices, Inc. All rights reserved.
> + */
> +
> +#ifndef __AE4DMA_HW_DEFS_H__
> +#define __AE4DMA_HW_DEFS_H__
> +
> +#include <rte_bus_pci.h>
> +#include <rte_byteorder.h>
> +#include <rte_io.h>
> +#include <rte_pci.h>
> +#include <rte_spinlock.h>
> +#include <rte_memzone.h>
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/*
> + * utility macros for bit setting and genmask
> + */
> +
> +#define BIT(nr)				(1 << (nr))
> +
> +#define BITS_PER_LONG   (__SIZEOF_LONG__ * 8)

We just fixed this in other drivers.

> +#define GENMASK(h, l)   (((~0UL) << (l)) & (~0UL >> (BITS_PER_LONG - 1 -=
 (h))))
> +
> +/* ae4dma device details */
> +#define AMD_VENDOR_ID	0x1022
> +#define AE4DMA_DEVICE_ID	0x149b
> +#define AE4DMA_PCIE_BAR 0
> +
> +/*
> + * An AE4DMA engine has 16 DMA queues. Each queue supports 32 descriptors
> + */
> +
> +#define AE4DMA_MAX_HW_QUEUES        2
> +#define AE4DMA_QUEUE_START_INDEX    0
> +#define AE4DMA_CMD_QUEUE_ENABLE 0x1
> +
> +/* Common to all queues */
> +#define AE4DMA_COMMON_CONFIG_OFFSET 0x00
> +
> +#define AE4DMA_DISABLE_INTR 0x01
> +
> +
> +/* temp defs added, need to remove if not required - start*/
> +
> +
> +/* Address offset for virtual queue registers */
> +#define CMD_Q_STATUS_INCR		0x1000
> +
> +/* Bit masks */
> +
> +#define CMD_Q_LEN			32
> +#define CMD_Q_RUN			BIT(0)
> +#define CMD_Q_HALT			BIT(1)
> +#define CMD_Q_MEM_LOCATION		BIT(2)
> +#define CMD_Q_STATUS			GENMASK(9, 7)
> +#define CMD_Q_SIZE			GENMASK(4, 0)
> +#define CMD_Q_SHIFT			GENMASK(1, 0)
> +#define COMMANDS_PER_QUEUE		8192
> +
> +
> +#define QUEUE_SIZE_VAL			((ffs(COMMANDS_PER_QUEUE) - 2) & \
> +						CMD_Q_SIZE)
> +#define Q_PTR_MASK			(2 << (QUEUE_SIZE_VAL + 5) - 1)
> +#define Q_DESC_SIZE			sizeof(struct ae4dma_desc)
> +#define Q_SIZE(n)			(COMMANDS_PER_QUEUE * (n))
> +
> +#define INT_COMPLETION			BIT(0)
> +#define INT_ERROR			BIT(1)
> +#define INT_QUEUE_STOPPED		BIT(2)
> +#define INT_EMPTY_QUEUE			BIT(3)
> +#define SUPPORTED_INTERRUPTS		(INT_COMPLETION | INT_ERROR)
> +#define ALL_INTERRUPTS			(INT_COMPLETION | INT_ERROR | \
> +					INT_QUEUE_STOPPED)
> +
> +/* bitmap */
> +enum {
> +	BITS_PER_WORD =3D sizeof(unsigned long) * CHAR_BIT
> +};
> +
> +#define WORD_OFFSET(b) ((b) / BITS_PER_WORD)
> +#define BIT_OFFSET(b)  ((b) % BITS_PER_WORD)
> +
> +#define AE4DMA_DIV_ROUND_UP(n, d)  (((n) + (d) - 1) / (d))
> +#define AE4DMA_BITMAP_SIZE(nr) \
> +	AE4DMA_DIV_ROUND_UP(nr, CHAR_BIT * sizeof(unsigned long))
> +
> +#define AE4DMA_BITMAP_FIRST_WORD_MASK(start) \
> +	(~0UL << ((start) & (BITS_PER_WORD - 1)))
> +#define AE4DMA_BITMAP_LAST_WORD_MASK(nbits) \
> +	(~0UL >> (-(nbits) & (BITS_PER_WORD - 1)))
> +
> +#define __ae4dma_round_mask(x, y) ((typeof(x))((y)-1))
> +#define ae4dma_round_down(x, y) ((x) & ~__ae4dma_round_mask(x, y))
> +
> +/* temp defs added, need to remove if not required - end*/
> +
> +/* Descriptor status */
> +enum ae4dma_dma_status {
> +	AE4DMA_DMA_DESC_SUBMITTED =3D 0,
> +	AE4DMA_DMA_DESC_VALIDATED =3D 1,
> +	AE4DMA_DMA_DESC_PROCESSED =3D 2,
> +	AE4DMA_DMA_DESC_COMPLETED =3D 3,
> +	AE4DMA_DMA_DESC_ERROR =3D 4,
> +};
> +
> +/* Descriptor error-code */
> +enum ae4dma_dma_err {
> +	AE4DMA_DMA_ERR_NO_ERR =3D 0,
> +	AE4DMA_DMA_ERR_INV_HEADER =3D 1,
> +	AE4DMA_DMA_ERR_INV_STATUS =3D 2,
> +	AE4DMA_DMA_ERR_INV_LEN =3D 3,
> +	AE4DMA_DMA_ERR_INV_SRC =3D 4,
> +	AE4DMA_DMA_ERR_INV_DST =3D 5,
> +	AE4DMA_DMA_ERR_INV_ALIGN =3D 6,
> +	AE4DMA_DMA_ERR_UNKNOWN =3D 7,
> +};
> +
> +/* HW Queue status */
> +enum ae4dma_hwqueue_status {
> +	AE4DMA_HWQUEUE_EMPTY =3D 0,
> +	AE4DMA_HWQUEUE_FULL =3D 1,
> +	AE4DMA_HWQUEUE_NOT_EMPTY =3D 4
> +};
> +/*
> + * descriptor for AE4DMA commands
> + * 8 32-bit words:
> + * word 0: source memory type; destination memory type ; control bits
> + * word 1: desc_id; error code; status
> + * word 2: length
> + * word 3: reserved
> + * word 4: upper 32 bits of source pointer
> + * word 5: low 32 bits of source pointer
> + * word 6: upper 32 bits of destination pointer
> + * word 7: low 32 bits of destination pointer
> + */
> +
> +/* AE4DMA Descriptor - DWORD0 - Controls bits: Reserved for future use */
> +#define AE4DMA_DWORD0_STOP_ON_COMPLETION	BIT(0)
> +#define AE4DMA_DWORD0_INTERRUPT_ON_COMPLETION   BIT(1)
> +#define AE4DMA_DWORD0_START_OF_MESSAGE		BIT(3)
> +#define AE4DMA_DWORD0_END_OF_MESSAGE		BIT(4)
> +#define AE4DMA_DWORD0_DESTINATION_MEMORY_TYPE   GENMASK(5, 4)
> +#define AE4DMA_DWORD0_SOURCE_MEMEORY_TYPE	GENMASK(7, 6)
> +
> +#define AE4DMA_DWORD0_DESTINATION_MEMORY_TYPE_MEMORY    (0x0)
> +#define AE4DMA_DWORD0_DESTINATION_MEMORY_TYPE_IOMEMORY  (1<<4)
> +#define AE4DMA_DWORD0_SOURCE_MEMEORY_TYPE_MEMORY    (0x0)
> +#define AE4DMA_DWORD0_SOURCE_MEMEORY_TYPE_IOMEMORY  (1<<6)
> +
> +struct ae4dma_desc_dword0 {
> +	uint8_t byte0;
> +	uint8_t byte1;
> +	uint16_t timestamp;
> +};
> +
> +struct ae4dma_desc_dword1 {
> +	uint8_t status;
> +	uint8_t err_code;
> +	uint16_t desc_id;
> +};
> +
> +struct ae4dma_desc {
> +	struct ae4dma_desc_dword0 dw0;
> +	struct ae4dma_desc_dword1 dw1;
> +	uint32_t length;
> +	uint32_t reserved;
> +	uint32_t src_lo;
> +	uint32_t src_hi;
> +	uint32_t dst_lo;
> +	uint32_t dst_hi;
> +};
> +
> +/*
> + * Registers for each queue :4 bytes length
> + * Effective address : offset + reg
> + */
> +
> +struct ae4dma_hwq_regs {
> +	union {
> +		uint32_t control_raw;
> +		struct {
> +			uint32_t queue_enable: 1;
> +			uint32_t reserved_internal: 31;
> +		} control;
> +	} control_reg;
> +
> +	union {
> +		uint32_t status_raw;
> +		struct {
> +			uint32_t reserved0: 1;
> +			/* 0=E2=80=93empty, 1=E2=80=93full, 2=E2=80=93stopped, 3=E2=80=93erro=
r , 4=E2=80=93Not Empty */
> +			uint32_t queue_status: 2;
> +			uint32_t reserved1: 21;
> +			uint32_t interrupt_type: 4;
> +			uint32_t reserved2: 4;
> +		} status;
> +	} status_reg;
> +
> +	uint32_t max_idx;
> +	uint32_t read_idx;
> +	uint32_t write_idx;
> +
> +	union {
> +		uint32_t intr_status_raw;
> +		struct {
> +			uint32_t intr_status: 1;
> +			uint32_t reserved: 31;
> +		} intr_status;
> +	} intr_status_reg;
> +
> +	uint32_t qbase_lo;
> +	uint32_t qbase_hi;
> +
> +};
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* AE4DMA_HW_DEFS_H */
> +
> diff --git a/drivers/dma/ae4dma/ae4dma_internal.h b/drivers/dma/ae4dma/ae=
4dma_internal.h
> new file mode 100644
> index 0000000000..28f8e902f9
> --- /dev/null
> +++ b/drivers/dma/ae4dma/ae4dma_internal.h
> @@ -0,0 +1,125 @@
> +/* SPDX-License-Identifier: BSD-3.0-Clause
> + * Copyright(c) 2024 Advanced Micro Devices, Inc. All rights reserved.
> + */
> +
> +#ifndef _AE4DMA_INTERNAL_H_
> +#define _AE4DMA_INTERNAL_H_
> +
> +#include "ae4dma_hw_defs.h"
> +
> +#define NO_OFFSET 0
> +#define ENABLE_DEBUG_LOG 0
> +
> +/**
> + * upper_32_bits - return bits 32-63 of a number
> + * @n: the number we're accessing
> + */
> +#define upper_32_bits(n) ((uint32_t)(((n) >> 16) >> 16))
> +
> +/**
> + * lower_32_bits - return bits 0-31 of a number
> + * @n: the number we're accessing
> + */
> +#define lower_32_bits(n) ((uint32_t)((n) & 0xffffffff))
> +
> +#define AE4DMA_DESCRITPTORS_PER_CMDQ 32
> +#define AE4DMA_QUEUE_DESC_SIZE  sizeof(struct ae4dma_desc)
> +#define AE4DMA_QUEUE_SIZE(n)  (AE4DMA_DESCRITPTORS_PER_CMDQ * (n))
> +
> +/** AE4DMA registers Write/Read */
> +static inline void ae4dma_pci_reg_write(void *base, int offset,
> +		uint32_t value)
> +{
> +	volatile void *reg_addr =3D ((uint8_t *)base + offset);
> +	rte_write32((rte_cpu_to_le_32(value)), reg_addr);
> +}
> +
> +static inline uint32_t ae4dma_pci_reg_read(void *base, int offset)
> +{
> +	volatile void *reg_addr =3D ((uint8_t *)base + offset);
> +	return rte_le_to_cpu_32(rte_read32(reg_addr));
> +}
> +
> +#define AE4DMA_READ_REG_OFFSET(hw_addr, reg_offset) \
> +	ae4dma_pci_reg_read(hw_addr, reg_offset)
> +
> +#define AE4DMA_WRITE_REG_OFFSET(hw_addr, reg_offset, value) \
> +	ae4dma_pci_reg_write(hw_addr, reg_offset, value)
> +
> +
> +#define AE4DMA_READ_REG(hw_addr) \
> +	ae4dma_pci_reg_read(hw_addr, 0)
> +
> +#define AE4DMA_WRITE_REG(hw_addr, value) \
> +	ae4dma_pci_reg_write(hw_addr, 0, value)
> +
> +static inline uint32_t
> +low32_value(unsigned long addr)
> +{
> +	return ((uint64_t)addr) & 0x0ffffffff;
> +}
> +
> +static inline uint32_t
> +high32_value(unsigned long addr)
> +{
> +	return ((uint64_t)addr >> 32) & 0x00000ffff;
> +}

You define this and upper32 differently why?

> +/**
> + * A structure describing a AE4DMA command queue.
> + */
> +struct ae4dma_cmd_queue {
> +	char *wr_src;
> +	phys_addr_t wr_src_phy;
> +	char *wr_dst;
> +	phys_addr_t wr_dst_phy;
> +	char memz_name[RTE_MEMZONE_NAMESIZE];
> +	volatile struct ae4dma_hwq_regs *hwq_regs;
> +
> +	struct rte_dma_vchan_conf qcfg;
> +	struct rte_dma_stats stats;
> +	/* Queue address */
> +	struct ae4dma_desc *qbase_desc;
> +	void *qbase_addr;
> +	phys_addr_t qbase_phys_addr;
> +	enum ae4dma_dma_err status[AE4DMA_DESCRITPTORS_PER_CMDQ];
> +	/* Queue identifier */
> +	uint64_t id;    /**< queue id */
> +	uint64_t qidx;  /**< queue index */
> +	uint64_t qsize; /**< queue size */
> +	/* Queue Statistics */
> +	uint64_t tail;
> +	uint32_t ring_buff_count;
> +	unsigned short next_read;
> +	unsigned short next_write;
> +	unsigned short last_write; /* Used to compute submitted count. */
> +	/* Queue-page registers addr */
> +	void *reg_base;
> +
> +} __rte_cache_aligned;
> +
> +struct ae4dma_dmadev {
> +	struct rte_dma_dev *dmadev;
> +	phys_addr_t status_addr;
> +	phys_addr_t ring_addr;
> +	void *io_regs;
> +	int id; /**< ae4dma dev id on platform */
> +	struct ae4dma_cmd_queue cmd_q[1]; /**< ae4dma queue */
> +	int cmd_q_count; /**< no. of ae4dma Queues */
> +	struct rte_pci_device pci; /**< ae4dma pci identifier */
> +	int qidx;
> +};
> +
> +
> +extern int ae4dma_pmd_logtype;
> +
> +#define AE4DMA_PMD_LOG(level, fmt, args...) rte_log(RTE_LOG_ ## level, \
> +		ae4dma_pmd_logtype, "AE4DMA: %s(): " fmt "\n", __func__, ##args)

Please break line after the AE4DMA_PMD_LOG, not later

> +
> +#define AE4DMA_PMD_DEBUG(fmt, args...)  AE4DMA_PMD_LOG(DEBUG, fmt, ## ar=
gs)
> +#define AE4DMA_PMD_INFO(fmt, args...)   AE4DMA_PMD_LOG(INFO, fmt, ## arg=
s)
> +#define AE4DMA_PMD_ERR(fmt, args...)    AE4DMA_PMD_LOG(ERR, fmt, ## args)
> +#define AE4DMA_PMD_WARN(fmt, args...)   AE4DMA_PMD_LOG(WARNING, fmt, ## =
args)
> +
> +#endif /* _AE4DMA_INTERNAL_H_ */
> +
> diff --git a/drivers/dma/ae4dma/meson.build b/drivers/dma/ae4dma/meson.bu=
ild
> new file mode 100644
> index 0000000000..e48ab0d561
> --- /dev/null
> +++ b/drivers/dma/ae4dma/meson.build
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright 2024 Advanced Micro Devices, Inc. All rights reserved.
> +
> +build =3D dpdk_conf.has('RTE_ARCH_X86')
> +reason =3D 'only supported on x86'
> +sources =3D files('ae4dma_dmadev.c')
> +deps +=3D ['bus_pci', 'dmadev']
> diff --git a/drivers/dma/meson.build b/drivers/dma/meson.build
> index 358132759a..0620e5d077 100644
> --- a/drivers/dma/meson.build
> +++ b/drivers/dma/meson.build
> @@ -9,6 +9,7 @@ drivers =3D [
>          'idxd',
>          'ioat',
>          'odm',
> +		'ae4dma',
>          'skeleton',
>  ]

Indentation should match other drivers

>  std_deps =3D ['dmadev']
> diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
> index 7bdc92b812..d7f0c47b56 100644
> --- a/lib/mempool/rte_mempool.h
> +++ b/lib/mempool/rte_mempool.h
> @@ -136,7 +136,7 @@ struct rte_mempool_objsz {
>  /**
>   * Alignment of elements inside mempool.
>   */
> -#define RTE_MEMPOOL_ALIGN	RTE_CACHE_LINE_SIZE
> +#define RTE_MEMPOOL_ALIGN	4096
>  #endif
> =20
>  #define RTE_MEMPOOL_ALIGN_MASK	(RTE_MEMPOOL_ALIGN - 1)

NAK
Changing the alignment of mempool objects for all users is wrong.
