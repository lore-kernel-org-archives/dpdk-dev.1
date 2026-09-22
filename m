Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7925CC982FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 08:02:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 569204026C;
	Tue, 22 Sep 2026 10:02:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BB6B6400D6
 for <dev@dpdk.org>; Tue, 22 Sep 2026 10:02:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790064150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DcHN6ClEZHdkAMtBM5uxLCVI1pIygFs+VHzABdiDeA4=;
 b=YU51fBxealWbtifUaKUVcMaOlyV/sbVtfR4d4oR+XbCz4YJTX7EeHaTNBYp34Rjqcw4TfM
 u67O9P1cLm531ONOEd+39z2wnyLtgLs8vA09FxDzWoN6A3WaKBHnzEBHfB97mEtKuRvUQ3
 B2MXxYg2c854YO36GIf7M1oRrlttAHQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-bGBUwnCePGKcLbQK7jOo9Q-1; Tue, 22 Sep 2026 04:02:28 -0400
X-MC-Unique: bGBUwnCePGKcLbQK7jOo9Q-1
X-Mimecast-MFC-AGG-ID: bGBUwnCePGKcLbQK7jOo9Q_1790064147
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5b75a9f9199so2043713e87.2
 for <dev@dpdk.org>; Tue, 22 Sep 2026 01:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790064147; x=1790668947;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DcHN6ClEZHdkAMtBM5uxLCVI1pIygFs+VHzABdiDeA4=;
 b=l8RS+91M6Wlro05b114vp0vVspr3Gyj5U6PDVEDMHmK9HGnTzj+Fs6rZpMiSztgZwy
 7HwLux/gFCsWXJk+92FV5zSwU5hQU3QDQjmQg8e3/BRw47Idt88y4Nm175oDrAtjdfGl
 0FX2+p4MTCXwF0+pb1nflrSiheI1DzWfdyhztqQja9m+3+dS5Ei2vLHQNsVn3uWPQzut
 VMYLyHZ7r1L3CqNUcLBwzYFBJ/lfSeKFyNTbFnDwSzMFRODZVcySXyiAKqVkHQBST6R9
 VdpMTwRYU486n9XxocEq3+71GA3w+H2e2HWYOQMIiXRWf6y5RtpHgNDNgSlS8j7/dKjh
 bOhA==
X-Gm-Message-State: AFuF++kmxOSgVN0e52i9hU77c8W4I0imEaagLb/40kqlbboQr308kzrT
 E2Xx0gHpY/BEgpg4RFwUMKybyHQM4nsWgcdw6anpJ9l7Jx+K7i3GZ6O0kSncB7SFKIJ0eNIVY8L
 Qk4SvDTFl3OqlaAjq3qEn4WTfhIYW8YIsi0LOvYaxmU06VPbUZmvacACgUPIXn62u4yaylpbE2z
 +bqO5DBSSvm+3qnVasMH4=
X-Gm-Gg: AYBFou1yedpBRadk0Psi4w4xdMcTyO5vTi1NX6w/F+wBn1XdPn9RIEAA0AYMsSp3lWr
 ncCrDJWcV+POgWxmKmfLWfLlfIFSn5GZku0PnwjhOmFleFNnsgRdTUZhOVK4oZp4sKpCF93XI6e
 SA6v6nxXydDwMeAWXxwJgnVLeobq/MdZqvy6T8q7hS2Eh8gdYOalcOvGTuYj+Dva6+Uu0C2FU2t
 NhcQPXgNSW1pQm1Pbn/u4Or8n4GEOjNCBegUHbkTmrIX+Xm
X-Received: by 2002:a05:6512:1322:b0:5b8:bc5e:d10b with SMTP id
 2adb3069b0e04-5b8c197034fmr4173521e87.53.1790064146651; 
 Tue, 22 Sep 2026 01:02:26 -0700 (PDT)
X-Received: by 2002:a05:6512:1322:b0:5b8:bc5e:d10b with SMTP id
 2adb3069b0e04-5b8c197034fmr4173470e87.53.1790064144849; Tue, 22 Sep 2026
 01:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1789044746.git.anatoly.burakov@intel.com>
 <cdedc9f8885ef46eb5a903c907c3b2bfeef0704b.1789044747.git.anatoly.burakov@intel.com>
 <CAJFAV8w8GbvBRQ+O5LkL=jJ0f57Y4XaKJbqXJjxpgk94Ane6Wg@mail.gmail.com>
 <03fd0cad-30d8-4754-8065-0216ec8328b4@intel.com>
In-Reply-To: <03fd0cad-30d8-4754-8065-0216ec8328b4@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 22 Sep 2026 10:02:11 +0200
X-Gm-Features: AclHuK-6CLGw9o5JmIlEoDm55_pTGrUoE-LPEh48oDDNY7DSWZBcfH44NqmfR4k
Message-ID: <CAJFAV8wVwuBsqiq-8ez6Ohg+vkwSh1Wsg=1aL3qpNnOSE3a1YA@mail.gmail.com>
Subject: Re: [PATCH v17 20/26] vfio: cleanup and refactor
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Wathsala Vithanage <wathsala.vithanage@arm.com>, 
 Bruce Richardson <bruce.richardson@intel.com>,
 Nipun Gupta <nipun.gupta@amd.com>, 
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, 
 Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>, 
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>, 
 Dimon Zhao <dimon.zhao@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yPLSiKDt8spDdJPthA5LGerlpqf5LFH4V_oF79nkvJU_1790064147
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 16 Sept 2026 at 13:20, Burakov, Anatoly
<anatoly.burakov@intel.com> wrote:
> >
> > The main concern for drivers is the "class" (physical, virtual) of addresses.
> > The noiommu notion was simple in that drivers understood they had to
> > handle physical addresses.
>
> That is arguably still the case. It is the same semantic meaning, just
> wrapped under a different name because I wanted to signal that using
> no-iommu mode is bad practice. It's still effectively IOMMU vs no-IOMMU.

Drivers do not care about this "bad practice".
No user will ever see this.

Most of the code now is generated by AI.
If you mix concerns in API, I am pretty sure the original intent will
be lost/distorted and we will just see some funny claims like "such
code is unsafe".


> >
> > There is some other concern about iommu capability that is not
> > captured in the new API.
> > Take a look at the PCI bus for example, where some decision is taken
> > on a DMA mask.
>
> Arguably this is not *VFIO* related (it's rather the property of IOMMU)
> so there is little place for that notion in this API except to group all
> IOMMU stuff under the same roof, which may or may not be semantically
> coherent depending on your view of what this API should be.

Well, yes, but drivers do not care about VFIO in the first place.

We may have a cleaner VFIO API now, but then drivers need to understand it.
I just want to preach for a simple API for the drivers, and maybe we
are missing an abstraction...



> >
> > In the end, it may mean that the whole iommu class discovery (that
> > impacts IOVA mode) should get revisited too... ?
> >
> > At least, with an *internal* VFIO API, we can revisit more easily in
> > the future, so those comments are not blocking the series.
> >
> >
>
> We can do all sorts of things now that we are allowed to, yes!

... but ok, I won't insist.
We will see in the future...


-- 
David Marchand

