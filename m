Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61213C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 17:32:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77F15402DA;
	Wed, 19 Feb 2025 18:32:49 +0100 (CET)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id 7EB9A4028B
 for <dev@dpdk.org>; Wed, 19 Feb 2025 18:32:48 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id ECE5C13809B9;
 Wed, 19 Feb 2025 12:32:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 19 Feb 2025 12:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1739986367;
 x=1740072767; bh=YUktkfJyVbN9rDUY5wFlc8SxZhjsLD+F3oUqe0GErvk=; b=
 ybZLLEuF8BjDIQgSBNDltBseH4UpnHv2/KmtUA5msQll4AodkcpNZ1xLEDzqJAR+
 5xgHSDUmNupgbvJvQhecu2+8+oCL5Tzi2IVEuoXpQLsFSyZOM4WY7bA1SDuysTF9
 fI5Nd6s+jSgjDNk3mxvUMm4BZNNh5b7zAyV312QCPoJbecxO+RYmwf1t/PMaQbrZ
 EcSkp8/Oq3sIM56jiCxdlLHuLnZhZb39yNpwt0gclChzfE+PK/PLcMrc/xldYV7e
 KrJmuOe1b0IN3qvIEiDASL+4T+iiE+OpEGLMQ4pWTvSnWgQUc8pKMdiNvMvKAqH6
 rI9+qttIMChEoEzZEk5E4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739986367; x=
 1740072767; bh=YUktkfJyVbN9rDUY5wFlc8SxZhjsLD+F3oUqe0GErvk=; b=U
 UO7/xhbDotKrqjRYCgBlEa4E/7TB9m5C7Cw/nY73N4qjhD7HAkjzevZcXLRka4BG
 gr1uq6zQfJJPHY47ndtswwzP27fdzodX1YTWUZZUK79ChLPftXSSOkLCHeBDeZeK
 abe9WDFgGB875tced1o7CaGGElunAgd2bVBYWU1FtE6T9M6auIo5ekSI7ugj2P+a
 IO07wxVJHtf3XsF1T2rN5vlso7rzM6tf2jr/FOyFCfBjiFc2bjBNQxsiz+wvxFhz
 nXF+buqSWpvElnbT37Y3HGc3jhsqaF9BpctIaRjGIOEUjxCdKKPxX6NtafJTF2a/
 Mg6NpYkqx8H+i3cyyFkqA==
X-ME-Sender: <xms:vxW2Z8C32ZV_-PaO6Wgz28ivhR-Acvme002Drlw9QmfkjjFE4EiKhg>
 <xme:vxW2Z-jYv5W7n21lhwEH2R9XIPlfHIoBIXyJRrMWT6uKVoHSwGBBaYm2zYTaBmYRl
 ea9u_FAv1DUSqI_wA>
X-ME-Received: <xmr:vxW2Z_ki0DyCOA25ItNYlHg2o5QgYBqrF2arzocdX_qsfjVTZBmGyEyVRIY08rgtQs7jVev7PQDosiT7cgqO3PFfNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeekjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgvth
 gvlhhsohhnsehnvhhiughirgdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhr
 ghdprhgtphhtthhopehmkhgrshhhrghnihesnhhvihguihgrrdgtohhmpdhrtghpthhtoh
 eprhgrshhlrghnugesnhhvihguihgrrdgtohhmpdhrtghpthhtohepnhgusegrrhhmrdgt
 ohhmpdhrtghpthhtohepfigrthhhshgrlhgrrdhvihhthhgrnhgrghgvsegrrhhmrdgtoh
 hm
X-ME-Proxy: <xmx:vxW2ZywGelQ4WSuZO3Koz4PAja0_N1Sooodats9xkK7ueO94gWN0tw>
 <xmx:vxW2ZxTtU645duCmEUaUqF5_zS9JtVulxs2Bx4hZyAU7PND30Dpjjw>
 <xmx:vxW2Z9aFEghmu0gCvCyNX-rqcCWtzowEF0ey2X21B39N64srJ0MsjQ>
 <xmx:vxW2Z6TRBnxtUxaF0rxsk5t8T44Brcm6kN08AjUahGComY6gXQi9iA>
 <xmx:vxW2ZwGNJK6DDB6Iq7yKFwhME5UxpEjv-QBbHPkmzKepelX2bZJv8VYh>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 12:32:46 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Gregory Etelson <getelson@nvidia.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "mkashani@nvidia.com" <mkashani@nvidia.com>,
 "rasland@nvidia.com" <rasland@nvidia.com>, nd <nd@arm.com>,
 Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>
Subject: Re: [PATCH] config/arm: update NVIDIA BlueField-3 configuration
Date: Wed, 19 Feb 2025 18:32:44 +0100
Message-ID: <11075212.CDJkKcVGEf@thomas>
In-Reply-To: <PAWPR08MB8909905417281D380EEBEF0B9FC52@PAWPR08MB8909.eurprd08.prod.outlook.com>
References: <20250216140420.216805-1-getelson@nvidia.com>
 <20250218104942.81984-1-getelson@nvidia.com>
 <PAWPR08MB8909905417281D380EEBEF0B9FC52@PAWPR08MB8909.eurprd08.prod.outlook.com>
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

19/02/2025 17:35, Wathsala Wathawana Vithanage:
> > Subject: [PATCH] config/arm: update NVIDIA BlueField-3 configuration
> > 
> > ARM configuration requires explicit `mcpu` specifications in the implementor
> > description.
> > 
> > The patch adds `mcpu` and `flags` description for the NVIDIA
> > BlueField-3 configuration.
> > 
> > Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> 
> Acked-by: Wathsala Vithanage <wathsala.vithanage@arm.com>

Adding error message:
"
The build was broken for BlueField-3:
    ERROR: Problem encountered:
    No suitable Arm mcpu name or custom mcpu definition object found.
"

and
Fixes: c02c01dbf907 ("config/arm: prefer strict use of -mcpu if supported")

Applied, thanks.


