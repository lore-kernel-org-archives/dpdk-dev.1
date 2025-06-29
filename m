Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DF1C7EE39
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 16:45:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E658240615;
	Sun, 29 Jun 2025 18:45:26 +0200 (CEST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id 7B9434025D
 for <dev@dpdk.org>; Sun, 29 Jun 2025 18:45:13 +0200 (CEST)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-7d098f7bd77so429865285a.0
 for <dev@dpdk.org>; Sun, 29 Jun 2025 09:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751215513;
 x=1751820313; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y12w40sA9sQT3kbPlkzyrN8+P43Ef3FPEyY76RLPRQk=;
 b=u2DZCVZzfy3O73BiXkeTDpZOvCUUbJKzcQhxBMX3Hqaa/ENQlUTM3jxsDam6w/kCm6
 7SGHaIQXNdxbKdO+7TC51hJEJYKgtNvjp5oOP1ewsP/UWqGJQYVDE93tyERZ1ZB4hX7M
 KaDzBqAo0aWuauX2CS9ImakcIFyoOdt/nfR9BzYPYfCIhWh0vRR0wmiNcaoSUx86ycAa
 RWe/QWPEhOy9HRKE8QYycwEVm6gVMuOoQLYl9agppfcMrUmo8lRQz1IEukHTMhyrZyQq
 aalPiJNEy3qKoRIDiJfnOihH663hXm/0EIAMiBtwQZHsioveeKQwi2uP9LwdypkztxeO
 jP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751215513; x=1751820313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y12w40sA9sQT3kbPlkzyrN8+P43Ef3FPEyY76RLPRQk=;
 b=oDOCIHAPEWE7Zq+x/skwQ74yARwwbK7mbRsnt33OS3AtG5XeQRCNJCw1Wg8g7AfTff
 WaRI5oLGYLsU469gxYTUxCmAghrMAghtOf8yGqY7bIxMMm2WBqgUNaVVlvizy6FdMvp+
 w31O7i9/2g88I5dXHFTNp+NKmx3LntesMnOCBaabhQgVEgKDUFHWu7OCJZm74XT5WWtD
 FerdiJJfeggWsg71mdy2er/GClImtoh0kgFnVRKaZg/CK2PTeAm2nmhDMKQAqbD3RIPL
 wyHCYxcZGznFVYfWwybWy8Z1OIxjV6uSAvgMfbMuBzZ5cwpg2/cQk+y6xTAPDp94dA9S
 ld3Q==
X-Gm-Message-State: AOJu0YwqL1vhqYDVuKlQIclcAihxUGZk2Dwj/ROgsfLkflGPlGsQxPL1
 q4xz1u220sxdcpflxtk1SqRuW0duASe3sN2vo1HTaVgOeyrTwZQ3MVXzyoqsUUUXLWY=
X-Gm-Gg: ASbGncvjONCpzAJvu5jpf+IZji7L9b8WvIcbUqsLVveA7eYzYTNUMIXtlt8/Ve9phrt
 9lDCChqK4VOz/TmiF3r+IjP5Lw/SjzhZNnO7n3u53GuTIgQIC5dbo6KvxjTy/HLVZnQQrM3XCAT
 BJ8ExMaE4KDTbw+2sTjcfuH1vvZw/mf1QsVVJxAhMgg95vn0Wq2/MuGM/On1WCLYf+cBEeRpn1+
 KYFpHUn8brlEEfJzFCkJczkr6snnW+IlZTjAlh8e5iP2FMgUAWhfJMXuAsYPCsY95xvCQ4YTjtD
 J8ca6Oa/vmbzQWKcgp0B/5f4sXlKcAiDVVrJ0bBHLnTYeqSsgt1o/wSRI99opRuwQm1QwN3MhAN
 yGP+JDCkyJWKZm4AdsNzyYhKlT0Lpt+vtLeOfnZg=
X-Google-Smtp-Source: AGHT+IGTMFzHxytMsRX8E0Q6cX1G7btRO3Z0SvlRiXgo+a5UIDB1NTh9aazgeH66aJl1DAdXAlZVXw==
X-Received: by 2002:a05:620a:3953:b0:7d4:3cf6:15f3 with SMTP id
 af79cd13be357-7d43cf61700mr1724850185a.25.1751215512782; 
 Sun, 29 Jun 2025 09:45:12 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d44316547bsm456985385a.27.2025.06.29.09.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 09:45:12 -0700 (PDT)
Date: Sun, 29 Jun 2025 09:43:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>
Subject: Re: [v4 08/10] net/dpaa: add devargs for enabling err packets on
 main queue
Message-ID: <20250629094354.77fbef83@hermes.local>
In-Reply-To: <20250611071039.2939950-9-vanshika.shukla@nxp.com>
References: <20250610091411.2500413-1-vanshika.shukla@nxp.com>
 <20250611071039.2939950-1-vanshika.shukla@nxp.com>
 <20250611071039.2939950-9-vanshika.shukla@nxp.com>
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

On Wed, 11 Jun 2025 12:40:37 +0530
vanshika.shukla@nxp.com wrote:

> diff --git a/doc/guides/nics/dpaa.rst b/doc/guides/nics/dpaa.rst
> index de3ae96e07..cc9aef7f83 100644
> --- a/doc/guides/nics/dpaa.rst
> +++ b/doc/guides/nics/dpaa.rst
> @@ -277,6 +277,9 @@ for details.
>  
>  * Use dev arg option ``drv_ieee1588=1`` to enable IEEE 1588 support
>    at driver level, e.g. ``dpaa:fm1-mac3,drv_ieee1588=1``.
> +* Use dev arg option ``recv_err_pkts=1`` to receive all packets including
> +  error packets and thus disabling hardware based packet handing
> +  at driver level, e.g. ``dpaa:fm1-mac3,recv_err_pkts=1``.
>  

Need blank line between items in list for doxygen to work.
