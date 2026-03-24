Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C60EF54AD7
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:12:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6560C40A67;
	Tue, 24 Mar 2026 17:12:50 +0100 (CET)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id B949040A4B
 for <dev@dpdk.org>; Tue, 24 Mar 2026 17:12:49 +0100 (CET)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-1274204434bso13400c88.1
 for <dev@dpdk.org>; Tue, 24 Mar 2026 09:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774368769;
 x=1774973569; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hfzs4M3Th+oSM8X3/9YyaAFXilkTJRDi1PJtrWrJqPY=;
 b=ycGJDV6gT2KNdOCobtlcW5KxXkziu2wzLixMprxXnqKrf34Lhk0qPI8teldF5ZPwxo
 uSRTV5Sii3IGbwFPj0VoaiGoGiCoJZY5etUF5He+IgAmkOi3zDcd3kbK/qA1kI7Xv38L
 ZjwXuCw+y33DcNvxaKrXdxCBEf/G+a3G6yB20epBh77+arvITlkOSygrxNPULR25NQH3
 dKN2G8P9/UphjypeDWLptoEqABJtO8WphID694zkh3N+NHNBfn15kTp3Mu0PBArZjaYM
 i5sZbAH0TBLKtp5X3mo6evFoxlSbU+ZRXs9oxP9JJly1LhSyRJC+qEqAWz91Ord9aep2
 HLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774368769; x=1774973569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hfzs4M3Th+oSM8X3/9YyaAFXilkTJRDi1PJtrWrJqPY=;
 b=ExprGl88wxqQnKNphTSV9E0tdffAnPNX5ysOuynb+PesHm5B6gRcWBohcHYQtKvTng
 khW5CCuVtkBqcQL4NZhF2NQMb73R9gDqWj8W61Q0WFBQnTlMTIAsvLe1hOUKoI+XTHLi
 HXQvzRwv0assh6dAIzTH7cncI3dBboSdsp2td2wFNziG7HVHRT4ypzxrBkYz9WxekG++
 q4y7Bdz+yQzlHuSoZlgvexvTDcwp0Y8g12SSQiq9f60Y3c+LQ/YyYyHFdp3+8I66cc0f
 v7dQRhfknj1hfBjLwcoiz1OHt70FixHA6RyKknSfI15WKtVhP+emL6rzke2MOKqpgmIg
 zCeQ==
X-Gm-Message-State: AOJu0YwPq3NhChfDjWrb6TP317hjsvATGrksErHAg5HZX+2i8EfOmnfK
 G/DuPpKLC/FqKoB6u908S/7SaScfKZGnD8/7DrncoBnR4JNI6C4VJAaC/Odbb8l0iZs=
X-Gm-Gg: ATEYQzyf56aMaelbrLQGhpFWb1FLMinEEaNZlO3TPQd7TdZT+pxLqYk+g/RETOhWfDl
 A9N5Y6QbB/qalOyb+KAk2RSmflPpCLGQKnOlUd6y+6qiEJiMP0Bf+WCP0r/0e0jlR72rOsDG3tN
 oTmZ2w/ie43/qeC/h1ufaIPNyZUZtIlbnpx8QBW4yv13rDPdklAFsAyZsTICkJNpiKZQgc42s/f
 SgqEsKnUC6S7UBD7Ytr7guC+6GCqhDbR2cf7MspK+XljKNddXGwiLQdEV/aTQxWzdkOUtoM1BAa
 U+D964FjwcVZB4VfQi4Rw4TbAILVcYK0RxIc/n7Kwti70sCb3SdIgGOQCQmbKP5e84nbHmwaoCN
 ph+n3g/RpOM7wQHzxl7Jn/zZtK5fstarrq0HdRo/l+qtpKP42g4vNw4WRYL+oVwlQOh80kKlAGR
 2/fMaJojQuzy1L8DMjaGhBMKs5iPes9oTofjY=
X-Received: by 2002:a05:7022:b91:b0:128:d396:f2ea with SMTP id
 a92af1059eb24-12a8e0e764cmr1700741c88.11.1774368768741; 
 Tue, 24 Mar 2026 09:12:48 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12a736bb1ccsm15239101c88.14.2026.03.24.09.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 09:12:48 -0700 (PDT)
Date: Tue, 24 Mar 2026 09:10:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, Parav
 Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, Hemant
 Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Rosen Xu <rosen.xu@altera.com>, Chenbo Xia <chenbox@nvidia.com>, Tomasz
 Duszynski <tduszynski@marvell.com>, Chengwen Feng
 <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>, Wei Hu
 <weh@microsoft.com>
Subject: Re: [PATCH 4/8] drivers: cleanup devargs lookup in bus scan
Message-ID: <20260324091045.2baca39e@phoenix.local>
In-Reply-To: <20260323105306.1531689-5-david.marchand@redhat.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260323105306.1531689-5-david.marchand@redhat.com>
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

On Mon, 23 Mar 2026 11:52:58 +0100
David Marchand <david.marchand@redhat.com> wrote:

> Don't hardcode the bus names in the RTE_EAL_DEVARGS_FOREACH() calls.
> The bus name is set by code in EAL.
> Even if there is nothing broken, let's reuse the name from the bus object.
> 
> And remove the now useless macros.
> 
> Note: in the ifpga bus case, the call was using an incorrect macro
> (IFPGA_ARG_NAME instead of IFPGA_BUS_NAME), yet it was working fine
> as this macro is aligned with the ifpga bus name.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

AI review feedback:

Patch 4/8: drivers: cleanup devargs lookup in bus scan

Error: In drivers/raw/ifpga/ifpga_rawdev.c, the change from
RTE_STR(IFPGA_BUS_NAME) to vdev->device.devargs->bus->name passes the
wrong bus name to rte_eal_hotplug_add(). The vdev is a vdev device
(registered via --vdev ifpga_rawdev_cfg,...), so
vdev->device.devargs->bus is the vdev bus, and its name is "vdev". The
old code correctly passed "ifpga" to hotplug the device onto the ifpga
bus. The new code would attempt to add the device to the vdev bus
instead.

Suggested fix: use rte_ifpga_bus.name (the ifpga bus object) or a local
string "ifpga" rather than deriving it from the vdev's devargs.
