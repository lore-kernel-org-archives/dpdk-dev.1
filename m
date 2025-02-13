Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3F1C0219D
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 08:34:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5847402A3;
	Thu, 13 Feb 2025 09:34:16 +0100 (CET)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id A8664402A3
 for <dev@dpdk.org>; Thu, 13 Feb 2025 09:34:14 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 8138825401B5;
 Thu, 13 Feb 2025 03:34:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Thu, 13 Feb 2025 03:34:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1739435653;
 x=1739522053; bh=kTRahOLhPi42Qrs63e+b6rcWXSCk8YkqP/ItbXHBZPo=; b=
 i5MgdrdEug123hzNQ7YixWOFHKkVFTtHfQ4VOVEl2hWkQ1kq4m/agq5VtgWt7wx8
 W/NlLMQ37yHxFY/A2yRArU0clMJKsd8Oh/OztmGwafDG4kclVs1KDt0wXSLeQ8/z
 D/mrHq4OK9FBsznXvOY6zB9aesikDwDZn69P1qcrTwLpCK5VOQh4vswQa+kqV0c7
 dzsHMNfssSrqq9S5jwNxv119RWWH3LQR58wVKw9jT76E1f00p065MVwm33YrxM/l
 MHUXr6+ZmAGkMbQy1UMFR/GOVISTALp/WjQ71nosn7IhlAtFzjhB3ITwP+oThUF8
 26pLHnxm4MlPUIHzXLQbgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739435653; x=
 1739522053; bh=kTRahOLhPi42Qrs63e+b6rcWXSCk8YkqP/ItbXHBZPo=; b=l
 gFhpty2IP4rwgQeHCzCcrCCmn6xARaKQxY8lrnLZZa2Sox/Sdhkjimgsp+JwCbxY
 Cd5iupT0NE0+m28/dJvjKEilNPqysne8pBpP+8f3GXIQZY0vpGEKIEwRBjnZWF5x
 cwEQxo/U6DGuGR/mCqldl+a7Wuob7SfyHOT6Es1U4xEFLjgCNqr/pTJCp0ObrIhy
 wHFqUMqPZW9rOn2BAZhu2rrlGytQUUcTT7MSlqAGFHB76Y6ns+cPm2tBY/jEf16f
 YuPMT1sjDm7XhQDrfz5UrZLPwvh14qbKRj3T84WyLXZHsKnHZi6fIhG5NyrumW2F
 b7KiokDsme5Yretp0Ci1A==
X-ME-Sender: <xms:g66tZ1u4GrHucOgVCsZll57HyGsQTryI9zPz5MqPe64pG_Btlf2F6g>
 <xme:g66tZ-dc3I_8ZpqooLYSkNKZpWpfPg910TMpuGVp8h3hR9eOoA06rTau7YT3yTxDS
 GdfDASg75KjVlwj3w>
X-ME-Received: <xmr:g66tZ4xwnypQq2gdifd_e_j80Vn47plrKShgxN6Pz7RaalFkOxJZS557uB39fQ_EimVYzdHWb7pHVNcyaFt9MKkocA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegieefudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvih
 hpihhnrdhvrghrghhhvghsvgesrghmugdrtghomhdprhgtphhtthhopeguvghvseguphgu
 khdrohhrghdprhgtphhtthhopehrohhrvghtiihlrgeslhhinhhugidrmhhitghrohhsoh
 hfthdrtghomhdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgv
 lhdrtghomhdprhgtphhtthhopehjohhhnhdrmhgtnhgrmhgrrhgrsehinhhtvghlrdgtoh
 hmpdhrtghpthhtohepughmihhtrhihrdhkohiilhhiuhhksehgmhgrihhlrdgtohhmpdhr
 tghpthhtoheprghjihhtrdhkhhgrphgrrhguvgessghrohgruggtohhmrdgtohhmpdhrtg
 hpthhtohepkhgvvghsrghnghdrshhonhhgsegrmhgurdgtohhmpdhrtghpthhtohepphgs
 hhgrghgrvhgrthhulhgrsehmrghrvhgvlhhlrdgtohhm
X-ME-Proxy: <xmx:g66tZ8Mf9NIdaJaS6M2wbAObDjxban17ePLq5E0Vo-qx-6Ljk_KjIg>
 <xmx:g66tZ198gsSbw2cgQQuwllCgIq5pBkN_HsCNQ6DzK1Lktg3j_0CmZg>
 <xmx:g66tZ8XqxnFK9kFnMvJbJ_btASeOHfPWuCJP14hie6cLwYdVf9ncbQ>
 <xmx:g66tZ2eF2N5p9F1GvVijeZAoLX1vB003FMKnk5R9VMFhkUO4-UlPlQ>
 <xmx:ha6tZ8h9bEhQKm9cz7RY_9IQJJ4j6i7_VRdn6SGVePlef9vby1LF1ygJ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 03:34:08 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 "roretzla@linux.microsoft.com" <roretzla@linux.microsoft.com>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>,
 "john.mcnamara@intel.com" <john.mcnamara@intel.com>,
 "dmitry.kozliuk@gmail.com" <dmitry.kozliuk@gmail.com>,
 "Ajit Khaparde (ajit.khaparde@broadcom.com)"
 <ajit.khaparde@broadcom.com>, "Song, Keesang" <Keesang.Song@amd.com>,
 "pbhagavatula@marvell.com" <pbhagavatula@marvell.com>,
 "jerinj@marvell.com" <jerinj@marvell.com>,
 "ruifeng.wang@arm.com" <ruifeng.wang@arm.com>,
 "mattias.ronnblom@ericsson.com" <mattias.ronnblom@ericsson.com>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>, "Yigit,
 Ferruh" <Ferruh.Yigit@amd.com>,
 "honnappa.nagarahalli@arm.com" <honnappa.nagarahalli@arm.com>,
 "wathsala.vithanage@arm.com" <wathsala.vithanage@arm.com>,
 "konstantin.ananyev@huawei.com" <konstantin.ananyev@huawei.com>,
 "mb@smartsharesystems.com" <mb@smartsharesystems.com>
Subject: Re: [PATCH v4 0/4] Introduce Topology NUMA grouping for lcores
Date: Thu, 13 Feb 2025 09:34:07 +0100
Message-ID: <2097299.UkFFEUeh36@thomas>
In-Reply-To: <PH7PR12MB85960CB35BB467CEBBC2CA2F82FF2@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20241105102849.1947-1-vipin.varghese@amd.com>
 <PH7PR12MB85960CB35BB467CEBBC2CA2F82FF2@PH7PR12MB8596.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

13/02/2025 04:09, Varghese, Vipin:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Adding Thomas and Ajit to the loop.
> 
> Hi Ajit, we have been using the patch series for identifying the topology and getting l3 cache id for populating the steering tag for Device Specific Model & MSI-x driven af-xdp for the experimental STAG firmware on Thor.
> 
> Hence current use of topology library helps in
> 1. workload placement in same Cache or IO domain
> 2. populating id for MSIx or Device specific model for steering tags.
> 
> Thomas and Ajith can we get some help to get this mainline too?

Yes, sorry the review discussions did not start.
It has been forgotten.

You could rebase a v2 to make it more visible.

Minor note: the changelog should be after --- in the commit log.


