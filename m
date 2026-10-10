Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD4ECA6017
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 07:27:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D926402B4;
	Sat, 10 Oct 2026 09:27:01 +0200 (CEST)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id 9BE9C4026D
 for <dev@dpdk.org>; Sat, 10 Oct 2026 09:26:59 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=wl3DIgX0eer6aw9pfZ+TkKeqKeoMN7u1AS6iRRRI4tU=;
 b=5zCKtd9Xliy/BWu9pQU+Qh0N1oVoVE7frF6vojgfgo7S058cc5/yaHT1BVnr7flgT5paz6pGp
 +xl26fKShDQiNFjA+/PzEot8AaMLByduxHdJ0xNmh80FX2P0z/1znhzfbaP0kZyjCVra5BzNwOS
 LrwidVoLC47ho6+FqzaPzmc=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4j1w374zlszRhXM;
 Sat, 10 Oct 2026 15:14:43 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id AA9AD40575;
 Sat, 10 Oct 2026 15:26:55 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sat, 10 Oct 2026 15:26:55 +0800
Message-ID: <afcff76f-b776-4a5f-a405-80cae31d4e3e@huawei.com>
Date: Sat, 10 Oct 2026 15:26:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] dma/imx_edma5: add statistics and dump
To: Gagandeep Singh <g.singh@nxp.com>, <dev@dpdk.org>
CC: <hemant.agrawal@nxp.com>, Prashant Gupta <prashant.gupta_3@nxp.com>
References: <20260811104933.3843522-1-g.singh@nxp.com>
 <20260812092929.563973-1-g.singh@nxp.com>
 <20260812092929.563973-6-g.singh@nxp.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260812092929.563973-6-g.singh@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500009.china.huawei.com (7.202.194.199)
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

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 8/12/2026 5:29 PM, Gagandeep Singh wrote:
> Add per-vchan statistics, virtual channel status reporting and a device
> dump callback to the eDMA5 dmadev.
> 
> stats_get and stats_reset expose the submitted, completed and error
> counters maintained by the data path, supporting both a single vchan and
> the RTE_DMA_ALL_VCHAN aggregate. vchan_status reports whether a channel is
> idle, active or halted on an unreaped error by inspecting the outstanding
> jobs in the software ring. dev_dump prints the device and per-vchan
> software state to aid debugging.
> 
> Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
> Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>

...
