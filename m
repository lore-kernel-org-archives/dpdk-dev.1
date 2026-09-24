Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0966BC98310
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 07:54:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D03F42F02;
	Thu, 24 Sep 2026 09:54:49 +0200 (CEST)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id 676C042EE5
 for <dev@dpdk.org>; Thu, 24 Sep 2026 09:54:46 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=r2/0lt3LskcXrdcP1g1Oxq7qajcYXyRkM26ZOb/zWr8=;
 b=fhd3cgURIl9kIHgnpRqRV879/gLEgqhxU9rgGUETC+wn74rWeOF3ANw8/1Kjv+dxvENQXjFD0
 SE9JU2i0+p80QUK6lzYqVcDNzyp7Cx1cvXwgIZnPBkN3Jaz1FsaXZl6oiJkd5RD5OQJ2SjuQcfc
 FrmClHJGICAiVnMgqyKYMAI=
Received: from mail.maildlp.com (unknown [172.19.162.197])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hr5Qq0MCTzpT0q;
 Thu, 24 Sep 2026 15:42:43 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id A83534057D;
 Thu, 24 Sep 2026 15:54:42 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 24 Sep 2026 15:54:39 +0800
Message-ID: <f55f9941-8be4-498e-aae8-6e571c27a101@huawei.com>
Date: Thu, 24 Sep 2026 15:54:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] doc: simplify NIC feature matrices
To: Thomas Monjalon <thomas@monjalon.net>, <dev@dpdk.org>
CC: Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, Shepard Siegel
 <shepard.siegel@atomicrules.com>, Ed Czeck <ed.czeck@atomicrules.com>, John
 Miller <john.miller@atomicrules.com>, Igor Russkikh <irusskikh@marvell.com>,
 Steven Webster <steven.webster@windriver.com>, Matt Peters
 <matt.peters@windriver.com>, Selwin Sebastian <selwin.sebastian@amd.com>,
 Julien Aube <julien_dpdk@jaube.fr>, Kishore Padmanabha
 <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>, Praveen Shetty <praveen.shetty@intel.com>, Potnuri
 Bharat Teja <bharat@chelsio.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Shai Brandes <shaibran@amazon.com>,
 Evgeny Schemeilin <evgenys@amazon.com>, Amit Bernstein <amitbern@amazon.com>, 
 Wajeeh Atrash <atrwajee@amazon.com>, Gagandeep Singh <g.singh@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>, John Daley <johndale@cisco.com>,
 Hyong Youb Kim <hyonkim@cisco.com>, Gaetan Rivet <grive@u256.net>, Joshua
 Washington <joshwash@google.com>, Xiaoyun Wang
 <cloud.wangxiaoyun@huawei.com>, Feifei Wang <wangfeifei40@huawei.com>, Xingui
 Yang <yangxingui@huawei.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Jingjing Wu <jingjing.wu@intel.com>, Andrew
 Boyer <andrew.boyer@amd.com>, Rosen Xu <rosen.xu@altera.com>, Wei Hu
 <weh@microsoft.com>, Jakub Grajciar <jgrajcia@cisco.com>, Matan Azrad
 <matan@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Dariusz
 Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Zyta Szpak
 <zyta@marvell.com>, Liron Himi <lironh@marvell.com>, Dimon Zhao
 <dimon.zhao@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen
 <sam.chen@nebula-matrix.com>, Martin Spinler <spinler@cesnet.cz>, Jiawen Wu
 <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>, Christian
 Koue Muf <ckm@napatech.com>, Serhii Iliushyk <sil-plv@napatech.com>, Vamsi
 Attunuru <vattunuru@marvell.com>, Devendra Singh Rawat
 <dsinghrawat@marvell.com>, Alok Prasad <palok@marvell.com>, Howard Wang
 <howard_wang@realsil.com.cn>, Chunhao Lin <hau@realtek.com>, Xing Wang
 <xing_wang@realsil.com.cn>, Javen Xu <javen_xu@realsil.com.cn>, Wenbo Cao
 <caowenbo@mucse.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Jie
 Liu <liujie5@linkdatatechnology.com>, Jerin Jacob <jerinj@marvell.com>,
 Maciej Czekaj <mczekaj@marvell.com>, Maxime Coquelin
 <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>, Jochen Behrens
 <jochen.behrens@broadcom.com>, Renyong Wan <wanry@yunsilicon.com>, Na Na
 <nana@yunsilicon.com>, Rong Qian <qianr@yunsilicon.com>, Xiaoxiong Zhang
 <zhangxx@yunsilicon.com>, Dongwei Xu <xudw@yunsilicon.com>, Junlong Wang
 <wang.junlong1@zte.com.cn>, Ming Ran <ran.ming@zte.com.cn>
References: <20260923032502.770744-1-thomas@monjalon.net>
 <20260923032502.770744-4-thomas@monjalon.net>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260923032502.770744-4-thomas@monjalon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

For hns3,
Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 9/23/2026 11:20 AM, Thomas Monjalon wrote:
> Remove rows which are not useful in the NIC feature overview:
> documentation availability, basic stats and link status.
> The last two are always implemented so they are not really useful
> in the matrix but their description are kept in features.rst.
> 
> Merge Rx/Tx variants when the support is identical:
> descriptor status and runtime queue setup.
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

