Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7630C28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 19:25:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8850F4028B;
	Fri, 28 Mar 2025 20:25:21 +0100 (CET)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47]) by mails.dpdk.org (Postfix) with ESMTP id D12984021E
 for <dev@dpdk.org>; Fri, 28 Mar 2025 20:25:19 +0100 (CET)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-6e8f43c1fa0so27596426d6.3
 for <dev@dpdk.org>; Fri, 28 Mar 2025 12:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743189919;
 x=1743794719; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G1KkExZturtLz9wVTn2Vs1SW9PXJ+1ryNSpBd/pGODo=;
 b=vJqCF4Ih32kWAwvz3w8X+2W7vJceGFIXOA30T0gk+eDxeStjpCH8k0TfLYbBDL8WDC
 0lYGBgoBPMjjlrAG3k6UlwB7tiF+2VwsYlbkjDXDctAZ4TARP26wM6vBeliB7fJlbHrp
 QBjhsC2udDJgNo1jjyABERhub/oqdg7hSeX6yIsiMBYu/YlGEyZ3BR83wI5RJsQ4CdEA
 kjFN7klOQZR+Zq6kb5jt8t2/sFu4+QNT2iXZHjnmsASc3Pj67mdB9G+ar2T/KRvMVmAd
 ediUxnZvhktmOn0LxeZ9i8VB7+7dT5x4ulDPu89T9oPKSdeXJ25XH3tw9Od8eCSp2v85
 V/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743189919; x=1743794719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G1KkExZturtLz9wVTn2Vs1SW9PXJ+1ryNSpBd/pGODo=;
 b=djKbVxE39VkTBvIhQxNvZ/zT0eRyZ9Akq+wNt7S2LakCsoVACt5SfOEBDnRnKDgcvq
 LpyTbcJAq9JHmtX3XczYCsTeWyfsx+fD/w9kKqp6qe6Vd6e8ifd7NrZKrS+5yRckYVf4
 VDd9K7l4gz6G9TkJvQwL8sNGegROqJY54jAIouDS9WauUViwJuJrpl2rfTocQNh5vNlr
 QVKwplePzD8/YtI076E/U99/h8jScmEJ5dfNcnC5W82tEM6wf9lnut3xQCdKK7t0+rp2
 c8qNu0mPEZwswwnQvtpbFgOAQPZdo9J779PRRmQVpPVmObPyYdsnW+ykVi1K7UOHXOJe
 xhSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0okskDetcxXs8yv+Unsa7gmRvlCKDWGAeQEYZmOkvOykhoDbL+7BoxPiEbh11KdolVy0=@dpdk.org
X-Gm-Message-State: AOJu0YwbWbt5Yj2Xg/nyda78bIzJBicYFKgY+HBq+cy5pJAC/G3hn1UV
 vfbZiPh9KOH3Q8FLuMipT7+14CMLmRLFsHAIyafVI7G4VVDj23OMReJVNLv7oh4=
X-Gm-Gg: ASbGncuH+nIkJJ/EhEyg/r0orHAq+bNLPoP0iU8nNIoDhU5tnVdvbE9wn9jIb+dAMH8
 LH4l8QcBoPo5N5QF29rtDvYX3+lsI/uDw710DY5pf7rfhdVYls248djmv+6bdMwQ9NFhoLdRqZU
 elb8ZsZZco7tRxJZMpL+eft9UpfKNnOKfLURbnrZU7LBXL3Q/DXTcoELDEYjBLhoz4nc7CdjIpe
 KYt0vZjOnQWzCPNJlgSPlajzZI+nZc+Ui899o/oJT7C+qjgJ2ZnXu7RXghna5nUa5rfO8L3gBiW
 rLdLpl9LEhwO2O1YDd667rTQjo2oc6wfRpFe9Kw3OB2EbPtMx5Tca7cQs975TB3aulBKriKguRS
 CaLB59Ej/nf4YegCFxjHV
X-Google-Smtp-Source: AGHT+IF6oap0ljKLt+26Ab7t0fXpvPvwChFpsbQkgldW0lW16HAolU5zzOzZB/CTXH1t30s9r99vJw==
X-Received: by 2002:a05:6214:268e:b0:6e8:fa38:46aa with SMTP id
 6a1803df08f44-6eed6271805mr3699966d6.33.1743189918784; 
 Fri, 28 Mar 2025 12:25:18 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eec97718ecsm14528086d6.82.2025.03.28.12.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 12:25:18 -0700 (PDT)
Date: Fri, 28 Mar 2025 12:25:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Etelson, Gregory" <getelson@nvidia.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, Morten =?UTF-8?B?QnI=?=
 =?UTF-8?B?w7hydXA=?= <mb@smartsharesystems.com>, dev@dpdk.org,
 techboard@dpdk.org, thomas@monjalon.net, mkashani@nvidia.com
Subject: Re: DPDK for rust
Message-ID: <20250328122516.733217af@hermes.local>
In-Reply-To: <2e308be8-8ef3-963-cbb2-5cf68a3d3b3d@nvidia.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB79@smartserver.smartshare.dk>
 <461725d-3c36-9b7f-c02d-f630dc8bc725@nvidia.com>
 <Z-V6GohKhnK0ywu2@bricha3-mobl1.ger.corp.intel.com>
 <2e308be8-8ef3-963-cbb2-5cf68a3d3b3d@nvidia.com>
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

On Fri, 28 Mar 2025 21:09:21 +0300 (IDT)
"Etelson, Gregory" <getelson@nvidia.com> wrote:

> >> Hello Morten,
> >>
> >> Thank you for raising these questions !
> >>  
> >>>
> >>> Do we want the DPDK project itself to support rust?
> >>> Or should parts of this be a DPDK hosted project, like grout?  
> >>
> >> Rust packages management is different.
> >> Also DPDK Rust code will eventually provide a different API.
> >> At this stage, DPDK hosted project looks like a good idea.
> >>  
> >
> > For ease of use, that would mean hosting a cargo registry, no?
> >  
> 
> That's correct - cargo registry is the native way.
> Also we may consider splitting the code between several crates.
> That approach can provide more flexible way to arrange files.

Talk to Luca. The current rust cargo registry model is causing
lots of grief for distro's such as Debian, Redhat, Ubuntu and SUSE.

Packaging is always a pain
