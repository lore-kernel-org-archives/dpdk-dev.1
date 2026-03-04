Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26158EF8FE7
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 14:06:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D050402A9;
	Wed,  4 Mar 2026 15:06:10 +0100 (CET)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id 7D87A4003C
 for <dev@dpdk.org>; Wed,  4 Mar 2026 15:06:08 +0100 (CET)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 8094A7A01A4;
 Wed,  4 Mar 2026 09:06:07 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Wed, 04 Mar 2026 09:06:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1772633167;
 x=1772719567; bh=gs2v0wF+ckip9e08ea2Ssy1k+mYk2XxmWICsfIQAr54=; b=
 XXJWSxr1+GTJTLue/nqYSzmhzyVPjsSDIGyDVENSTMX6ALc1sD1cXNeHxHbPnb2t
 8szouOSK8qBFfA1a8i0riTIo86JQ1/sltA9OU1cvw909wlLPHycbdQ00mTf1EW5A
 xUV/a5ROV8Idzb7ksexpmR/0NVja/u2jjL05s14bo4ITUyDSGUPTiR5RgCaIP0+F
 W0xM+dXLDTbNSLKIgaKP3eukvT/a30JRzg+ocPN8E5b6P8TmpN8CuyyvJRqcxKOE
 LSmPnyIIHep5UFQxaDQfORRmwepmi4YyKexGonyPHzYYrb1Yde28SxrI6YP6QUl5
 Kw/WPgQUP5bJ9wJ7DWzbsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772633167; x=
 1772719567; bh=gs2v0wF+ckip9e08ea2Ssy1k+mYk2XxmWICsfIQAr54=; b=s
 miKGM94nIsO6tMWYY3sP0uGPrPdEP2F5LmXImApcRt/t6V56JtfmFhx1Ron37+GT
 lBuyQXE6Xoq605PuO4YXkR/GweZXrv7Hgk8zwKgUDHwkIRmFdb69IMEkhGdnNicJ
 /fFtjEmnSXR0K2hcJU9AuXwfD93BLkIpHbVl1Ml6PSdGixN9ElqnL1ui7pztmAJw
 I+Hnc52y+eC0AlizsYnJxKj2ZXAqCmwdIadjZuJiPTqGa9xxApKXLvmpfnTVKmA/
 +5preh9xtVuG4nq7Hg6WZbAXaHYURE3yAXS+5k/om3LaNHesqNlBGjY+rZhK2jGc
 uDzT4MtMgb64wVkgQlcEw==
X-ME-Sender: <xms:TzyoafPCEW9TfpH7gdLAOZ8YjrQMYpNGy1bTh2DTyI0eiocwC-SqgQ>
 <xme:TzyoaS6ttrWdTl_Q0G_O6qYvtrV9FWdMaGyGxdeH5NiWIgwhezLw-SGpWPmKnw7WB
 _md9EMk0zNGp5XFhRKBg0fW8Sb1-k0exaKkQvDe94gF-Wfwtw-p>
X-ME-Received: <xmr:TzyoaZ1YAF-UjhwA75fU5j6HyfCO8GQQFjFVEDb3oW4QKGljYEzlH4R8tZfxF_jBdmwEulX5l8bqYTf4n-o5JN6k5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieefieejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvkeetheduvdeukeetjeetledvfeelfeetkeeujeffjefhlefftdev
 fffgueetteenucffohhmrghinhepuhgtfidrtgiipdhgihhthhhusgdrtghomhenucevlh
 hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshes
 mhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpoh
 huthdprhgtphhtthhopehmrghurhhitggvrdhgrhgvvghnsehmrghurhhitggvghhrvggv
 nhhjrhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhope
 gvrghgohhsthhinhhisehnvhhiughirgdrtghomhdprhgtphhtthhopehgvghtvghlshho
 nhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepmhhkrghshhgrnhhisehnvhhiughirg
 drtghomhdprhgtphhtthhopehrrghslhgrnhgusehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:TzyoaTwK8JD1FVXgYG_3A7HngqDZ-fCfLH8gff3WemIWlkVt3-GG9g>
 <xmx:TzyoaTueeR_9T-1D5fzZu9_kzp8QlgG3Czdr54WODiX0_Mvv_TjxIw>
 <xmx:TzyoadzQQpfDXhsIiad-gqkSPgzco0wNsQo1WNnW3Wwei7gCixW4ZA>
 <xmx:TzyoaeBkXihb2bSAisaHoVitSu_OhlRP8wbnFeOM1UvKNiscnOLTZA>
 <xmx:TzyoaYqPCbZxse5lY8AppKeo8OdGnBJG-6jOuF-1rVQPrOwkXdJktPM_>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 09:06:06 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Maurice Green <maurice.green@mauricegreenjr.com>
Cc: dev@dpdk.org, eagostini@nvidia.com, getelson@nvidia.com,
 mkashani@nvidia.com, rasland@nvidia.com
Subject: Re: [PATCH 7/9] gpu/cuda: extend NVIDIA GPU device ID list
Date: Wed, 04 Mar 2026 15:06:04 +0100
Message-ID: <6937723.QfHCVqEBuz@thomas>
In-Reply-To: <20260304132840.12740-1-maurice.green@mauricegreenjr.com>
References: <2884915.PYKUYFuaPT@thomas>
 <20260304132840.12740-1-maurice.green@mauricegreenjr.com>
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

04/03/2026 14:28, Maurice Green:
> On Wed, 17 Sep 2025, Thomas Monjalon wrote:
> > I feel we can scratch all these patches and do 1 well synchronized,
> > and documenting a sync command as code comment.
> 
> Agreed. I also noticed 0x1df6 in this patch is already present in 
> main. I would be happy to submit a replacement patch doing a full
> sync with the NVIDIA open kernel modules device list if that is useful.
> Having the updated device IDs for this driver would really help.
> 
> Maurice Green <maurice.green@mauricegreenjr.com>

I had started to work on it.

An abstract to see how it looks like:

+#define NVIDIA_GPU_GV100GL_TESLA_SXM2_16      0x1db0 /* Tesla V100 SXM2 16GB */
+#define NVIDIA_GPU_GV100GL_TESLA_SXM2_16_LS   0x1db1 /* Tesla V100 SXM2 16GB LS / GRID V100X */
+#define NVIDIA_GPU_GV100GL_TESLA_DGXS_16      0x1db2 /* Tesla V100 DGXS 16GB */
+#define NVIDIA_GPU_GV100GL_TESLA_FHHL_16      0x1db3 /* Tesla V100 FHHL 16GB / GRID V100L */
+#define NVIDIA_GPU_GV100GL_TESLA_PCIE_16_LS   0x1db4 /* Tesla V100 PCIe 16GB LS / GRID V100 */
+#define NVIDIA_GPU_GV100GL_TESLA_SXM2_32_LS   0x1db5 /* Tesla V100 SXM2 32GB LS / GRID V100DX */
+#define NVIDIA_GPU_GV100GL_TESLA_PCIE_32      0x1db6 /* Tesla V100 PCIe 32GB / GRID V100D */
+#define NVIDIA_GPU_GV100GL_TESLA_DGXS_32      0x1db7 /* Tesla V100 DGXS 32GB */
+#define NVIDIA_GPU_GV100GL_TESLA_SXM3_32_H    0x1db8 /* Tesla V100 SXM3 32GB H */

And others with partial name:

+#define NVIDIA_GPU_GA100      0x20b8 /* A100X 80GB DPU */
+#define NVIDIA_GPU_GA100      0x20b9 /* A30X 24GB DPU */
+#define NVIDIA_GPU_GA100      0x20bb /* DRIVE A100 PROD */
+#define NVIDIA_GPU_GA100      0x20bd /* A800 SXM4 40GB */
+#define NVIDIA_GPU_GA100      0x20be /* GRID A100A */
+#define NVIDIA_GPU_GA100      0x20bf /* GRID A100B */
+#define NVIDIA_GPU_GA100      0x20c2 /* CMP 170HX */
+#define NVIDIA_GPU_GA100      0x20f0 /* A100 PG506-207 */
+#define NVIDIA_GPU_GA100      0x20f1 /* A100 PCIe 40GB / GRID A100 */
+#define NVIDIA_GPU_GA100      0x20f2 /* A100 PG506-217 */
+#define NVIDIA_GPU_GA100      0x20f3 /* A800 SXM4 80GB / GRID A800DX */
+#define NVIDIA_GPU_GA100      0x20f5 /* A800 80GB PCIe / GRID A800D */
+#define NVIDIA_GPU_GA100      0x20f6 /* A800 40GB PCIe / GRID A800 */
+#define NVIDIA_GPU_GA100      0x20fd /* AX800 Converged Accelerator */
[...]
+#define NVIDIA_GPU_GH100      0x232c /* H20 HBM3e */
+#define NVIDIA_GPU_GH100      0x2330 /* H100 SXM5 80GB */
+#define NVIDIA_GPU_GH100      0x2331 /* H100 PCIe */
+#define NVIDIA_GPU_GH100      0x2335 /* H200 SXM 141GB */

As you can see it requires knowledge to get the right name for each ID.
Not everything is in https://pci-ids.ucw.cz/
https://github.com/NVIDIA/open-gpu-kernel-modules is a good source but not perfect as well.


