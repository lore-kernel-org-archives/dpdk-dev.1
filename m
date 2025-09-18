Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB4ECAC59F
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 08:48:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F5FA402C9;
	Thu, 18 Sep 2025 10:48:17 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id CABDB402C5
 for <dev@dpdk.org>; Thu, 18 Sep 2025 10:48:15 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 2E6101400276;
 Thu, 18 Sep 2025 04:48:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Thu, 18 Sep 2025 04:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758185295;
 x=1758271695; bh=XyttnMFMuC2DkGmUqr1FF9qv1meIqS5ur6tUsikcUKE=; b=
 bbx8TYP8pgVMFV/k4sq88xWjLQTJpBszujNCC42+vn69tDO/i0ihIJxk1gGR5nva
 W2+D7xcVDAJp8vzQ0qYLx+DTumT/e5BAWJAL7yjWvmHmawFdeyFIntl6XnKzLlEG
 zBkXfokuR+YQG6VYg3XKzIVDLtqtFwuPC3Tk+4T+x4TiPtYlfjJIJzcgSDC3qzSw
 ospCXBhWmY9UqM9Yv0y/NifsfuNG+QPXIqmB0YvXj+pA2Vma1tx/ZrGuYApJsgAv
 B3R0Myy+Qakall8fOpetg/w7tSOqJnTMp69QznxQFMCYh17Oz+aLoAvc9Le+CNVS
 vJjrpO/3qzVoGihl8zp+Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758185295; x=
 1758271695; bh=XyttnMFMuC2DkGmUqr1FF9qv1meIqS5ur6tUsikcUKE=; b=d
 pUY7jy4kMQZnu+EKBSKhx6qjN5t7jYGWm/vitZ/F6rV/OIYO4fSZPsrrNzM3tqzN
 nM8QOEmX82mANwNteZE5l9PGk+Olk/vnHDYiyDND013njc4CjwilpiF0IMMMMXL4
 PUGfo68mCDhilanrHtBkjb63mD6tDcIC2lfYocwan0PyiXra3wWZ3OSTVEG/cSln
 gxdkypG0lpoy7mT0b97KVgTIljA1lnjlHFRpxC2G8xp8WvzvE0QZy1tceo4c51Ta
 MP6r5i6Dqa+QlmB66G3IgBMNc7FC/4pwHAkC4hcNzYY/6Xn9jJT4lq3Hd/OdBZMs
 Co8hJrLnqStsjZ4+ES0lA==
X-ME-Sender: <xms:TsfLaMmlXNJqM5F2J15B0qeXjnYvNFCUQK9afw1-_RXXP4UU6iAxCA>
 <xme:TsfLaBNAnHkqazAZwNUzKzTwkvtjund1F2XV0W9iymlhcQhd_rqOnrhh7Sw6FcBnJ
 SI-DFLXRIWHVw5pEQ>
X-ME-Received: <xmr:TsfLaK1Ayc8iPach91hetGp9iKH6GYG4Eu9K2hsEBvCja80I_UIPT4xWq0SbcQJpeDP1cGHgFQdHxAJWGSVukxOBvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheeklecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplh
 humhgsvghrrdhorhhgpdhrtghpthhtohepuggrvhhiugdrmhgrrhgthhgrnhgusehrvggu
 hhgrthdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhope
 hmrgigihhmvgdrtghoqhhuvghlihhnsehrvgguhhgrthdrtghomhdprhgtphhtthhopegr
 nhgrthholhihrdgsuhhrrghkohhvsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:TsfLaImKWpEDEyj6KNLYjRZhtN3di9Sfs_Dl2IZwDXp__RNRcU3tlQ>
 <xmx:TsfLaJU88UUA_T7NRicYgB_sEuz22CbJU33V8zDl35p5GgDD4T3ReQ>
 <xmx:TsfLaGtmlsiBO4uwGnPkBij5Ssz-vlrWLQ5Hg6nMDYpqSbnimjmnCw>
 <xmx:TsfLaEYXrsDLwc4vBkb1Kl1J859SpmsXDAp62G3cgasMQmjXJSBmpw>
 <xmx:T8fLaIY4gQOuneuf5bT3KJYzj9CF0vmbpDtZX5SWN7beDOKhl5IpIYpU>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 04:48:13 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Marchand <david.marchand@redhat.com>, dev@dpdk.org,
 maxime.coquelin@redhat.com, anatoly.burakov@intel.com
Subject: Re: [RFC v2 8/9] uapi: import VFIO header
Date: Thu, 18 Sep 2025 10:48:12 +0200
Message-ID: <2776153.atdPhlSkOF@thomas>
In-Reply-To: <20250905211157.00ab0e5a@hermes.local>
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <20250903151800.1965006-9-david.marchand@redhat.com>
 <20250905211157.00ab0e5a@hermes.local>
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

06/09/2025 06:11, Stephen Hemminger:
> On Wed,  3 Sep 2025 17:17:58 +0200
> David Marchand <david.marchand@redhat.com> wrote:
> 
> > Import VFIO header (from v6.16) to be included in many parts of DPDK.
> > 
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> >  kernel/linux/uapi/linux/vfio.h | 1836 ++++++++++++++++++++++++++++++++
> >  kernel/linux/uapi/version      |    2 +-
> >  2 files changed, 1837 insertions(+), 1 deletion(-)
> >  create mode 100644 kernel/linux/uapi/linux/vfio.h
> 
> The linux kernel source tree has a well defined method for making exported
> uapi headers: 
> 	make headers_install
> 
> DPDK should not be inventing its own method for this.
> 
> If you use this on current released kernel (6.16) you will get slightly different file.
> The point of having DPDK vfio.h was to workaround case where distro was too old;
> not to be different.

The diff below is because of a different (but compatible) version.
I don't see the point about the method.

[...]
>  struct vfio_device_bind_iommufd {
>  	__u32		argsz;
>  	__u32		flags;
> +#define VFIO_DEVICE_BIND_FLAG_TOKEN (1 << 0)
>  	__s32		iommufd;
>  	__u32		out_devid;
> +	__aligned_u64	token_uuid_ptr;
>  };



