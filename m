Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6222EC36010
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Apr 2025 07:16:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9776440E3B;
	Fri,  4 Apr 2025 09:16:49 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id A8E5D40E35
 for <dev@dpdk.org>; Fri,  4 Apr 2025 09:16:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 98AEE4A
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1743751007;
 bh=EdsKcVZaiN/tpCxAxWR8bHeQKClijl2Kxvj5ZWZ4fQg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HN/6oa3/G5bFHq1FTaGfqke+aIVlQJYvgn13c0qIbMkZhkKTAGO1Lay8Iig0oyrh7
 wY9vzd8j7SrrgRpJ7NPS6AerTfWapqLTwW/+ioyukeUiOyIb6+FuJWvBaFH1mFSF+L
 MwKBP0+llx4BSxWUZwV7Lu3Njvuyb+GfkeBOx6Zc=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 98AEE4A;
 Fri,  4 Apr 2025 10:16:47 +0300 (MSK)
Message-ID: <4905258b-783d-4f6c-adca-74e156592cd3@oktetlabs.ru>
Date: Fri, 4 Apr 2025 10:16:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/8] build: mark exported symbols
To: Hemant Agrawal <hemant.agrawal@oss.nxp.com>,
 David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com, Nicolas Chautru <nicolas.chautru@intel.com>,
 Parav Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@altera.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>, Anoob Joseph <anoobj@marvell.com>,
 Andrew Boyer <andrew.boyer@amd.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Liron Himi <lironh@marvell.com>,
 Chaoyong He <chaoyong.he@corigine.com>,
 Nagadheeraj Rottela <rnagadheeraj@marvell.com>,
 Srikanth Jampala <jsrikanth@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>, Tejasree Kondoj
 <ktejasree@marvell.com>, Gagandeep Singh <g.singh@nxp.com>,
 Kai Ji <kai.ji@intel.com>, Vamsi Attunuru <vattunuru@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Shijith Thotton <sthotton@marvell.com>,
 Pravin Pathak <pravin.pathak@intel.com>,
 Ashwin Sekhar T K <asekhar@marvell.com>,
 Igor Russkikh <irusskikh@marvell.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>, Chas Williams <chas3@att.com>,
 "Min Hu (Connor)" <humin29@huawei.com>, Ian Stokes <ian.stokes@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Akhil Goyal <gakhil@marvell.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashish.gupta@marvell.com>,
 =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Jerin Jacob <jerinj@marvell.com>,
 Harry van Haaren <harry.van.haaren@intel.com>, Min Zhou
 <zhoumin@loongson.cn>, David Christensen <drc@linux.ibm.com>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Byron Marohn <byron.marohn@intel.com>, Yipeng Wang <yipeng1.wang@intel.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Abhinandan Gujjar <abhinandan.gujjar@intel.com>,
 Amit Prakash Shukla <amitprakashs@marvell.com>,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>,
 Elena Agostini <eagostini@nvidia.com>, Zhirun Yan <yanzhirun_163@163.com>,
 Jiayu Hu <hujiayu.hu@foxmail.com>, Sameh Gobriel <sameh.gobriel@intel.com>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>, Gaetan Rivet <grive@u256.net>,
 Volodymyr Fialko <vfialko@marvell.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250403165845.1315380-1-david.marchand@redhat.com>
 <20250403165845.1315380-6-david.marchand@redhat.com>
 <ef319345-7e67-c539-4b03-39793caf311e@oss.nxp.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <ef319345-7e67-c539-4b03-39793caf311e@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 4/4/25 08:48, Hemant Agrawal wrote:
> for DPAA/FSLMC changes
> 
> Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
> 


For common/sfc_efx:
Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

