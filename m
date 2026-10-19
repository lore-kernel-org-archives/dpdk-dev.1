Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B305606AAD6
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 15:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IpHC2iYu
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD4F440609;
	Mon, 19 Oct 2026 17:46:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C267940609
 for <dev@dpdk.org>; Mon, 19 Oct 2026 17:46:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792424780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vk4+fUtMDYpOKeXwLHUVoJUuhC3BVjs6siZ64WfTl1s=;
 b=IpHC2iYu+DEUSrO+TvbdJGxUNT+cUGNHJwXdu72fgQ7H3AnBmgCZX2e3JPSMSmf5sxhHwN
 3Dz/KVQZJDjWvzWGU0mLi6lGCywAmkZX9WRfWxFOfdYJaNZtPov4wPPPqd4Zj9TogXaTMn
 XzoTrlfeUw+aSgdAcCVme5f2ebEGGO0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-YEqlkZ2wPUi7RHT0zUXtnw-1; Mon, 19 Oct 2026 15:46:16 +0000
X-MC-Unique: YEqlkZ2wPUi7RHT0zUXtnw-1
X-Mimecast-MFC-AGG-ID: YEqlkZ2wPUi7RHT0zUXtnw_1792424775
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5bccbdf58e2so1213034e87.3
 for <dev@dpdk.org>; Mon, 19 Oct 2026 08:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792424775; x=1793029575;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vk4+fUtMDYpOKeXwLHUVoJUuhC3BVjs6siZ64WfTl1s=;
 b=syKJCwcVb2Atb8hhCFQyksH4x3sNrqgYSyD+PSp9WGRVTGp1a34woQIjkBeL8YfJcl
 NnELrUt+3c0UP4eln3RARo07h8fouddKsITM5n72w+GxNfL2A7h9ukfl1rWaEvI3QGQ5
 5S/Po8h7ojFDU3iygVtNVWs2ovOs70bS3v7YnT/MXRUB2C4RlQa7AkG2QzKe6EN2iABk
 axX+S939KeiI87T/+66oifc9hkkfVwfqaAiqu4U4fXIm/yY9nCh0bcIWyNWzEtIYItJg
 jhvfJIvL3IbrxpWNoRqXASVj1KpZt68P49VmFyjBH9Qr2vjoYzfRFTwlODCyS6SoYqom
 4KkQ==
X-Gm-Message-State: AFq9FYKqzThtdxNgF4hl3cykhQ6vxBSvdtKnLS8hGgaSZpzziF6XZ50s
 f0ApEyWkbh7xr+OovcCHItF3bNbqm7zatSgsNvWAGS4P+DOsy+l/FEpWFylj8IijWGAY5133ZGf
 YGTFTnh3WbOz6E2StF7M0CKwm9sLFUAOkQIR4VRGPPTFfynSluuvtvSyXRzn5sPorqV+FaSlnvN
 FXal0AMXK/grEMbEaRgMI=
X-Gm-Gg: AYBFou0zmlS96lEc6tVmIdr4I53Hq+QnJl5LOoe+UpJzuLxzWcPTQfAPalkbGU0QZza
 wUmzjNU3BUC9bf3lmGS6+rf135nc8DlsQ/49ouTpDO0PL8GNPmVtiJxkz7B8nKLNKsdSrvITmnH
 S5j7rxvhKQ5p0sNA0cEtrpbuWOwgEDSrKlNMhwHw1rfq2nv2C9WXJ22XjD/k6yPlDGdqVHfjzF8
 LbgIBIImGCN5XxfIUwHiqbzVbneZyHkmV7YSAHWeo1zGc3Vp6W80z/vOMyGyWqoW4SN9KQBo/Vu
 AawSfdm8gCO06SCBkp6VHXnEv3sA2rdI8H3OcM76bG4=
X-Received: by 2002:a05:6512:668d:10b0:5be:5184:8c23 with SMTP id
 2adb3069b0e04-5be5184a983mr1379657e87.3.1792424774797; 
 Mon, 19 Oct 2026 08:46:14 -0700 (PDT)
X-Received: by 2002:a05:6512:668d:10b0:5be:5184:8c23 with SMTP id
 2adb3069b0e04-5be5184a983mr1379648e87.3.1792424774339; Mon, 19 Oct 2026
 08:46:14 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260918165133.1945089-1-bruce.richardson@intel.com>
In-Reply-To: <20260918165133.1945089-1-bruce.richardson@intel.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Mon, 19 Oct 2026 17:46:00 +0200
X-Gm-Features: AclHuK-5uMtwlOq5nOsJeJOWUe0FDKIn_tyH_Vo4OCic1s1elo4XtPIebmTx1OU
Message-ID: <CAO55csy-BvUXQ-5WJRu=AGd31RAJCw9MbpoE34UhidTR_rAmGQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa/ifc: fix argument parsing
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, stable@dpdk.org, 
 Xiao Wang <xiao.w.wang@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Mo9oQt37XsvGvjhYUv8ynJoqd_sXGGx2OGr4VfonSzg_1792424775
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Sep 18, 2026 at 6:51=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> The argument parsing in ifcvf was storing only 2 bytes to a 4-byte
> integer value, leaving the int possibly with garbage in the top two
> bytes. However, despite being an int, the value was actually used as a
> boolean both times something was passed. Therefore, fix the bug by using
> bool values and change the arg parsing function to match that.
>
> Bugzilla ID: 2040
> Fixes: 40ef35f4a504 ("net/ifc: detect if VDPA mode is specified")
> Cc: stable@dpdk.org
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/vdpa/ifc/ifcvf_vdpa.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime

