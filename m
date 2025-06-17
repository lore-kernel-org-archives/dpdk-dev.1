Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA9BC71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 13:51:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5617E410E3;
	Tue, 17 Jun 2025 15:51:43 +0200 (CEST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id F235340BA4
 for <dev@dpdk.org>; Tue, 17 Jun 2025 15:51:41 +0200 (CEST)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-6fad4a1dc33so58647786d6.1
 for <dev@dpdk.org>; Tue, 17 Jun 2025 06:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750168301;
 x=1750773101; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gTTHIoORgu9Bflu6BYfPSZiqqQzuwh+Addr9boq0Ofo=;
 b=kgmlpaIRfPSGVNrxnpAuM/xEup18LiKxGLlA6DWCEnxuF9Iq3Rgzp7d2gSs1ZJrCHe
 RAq4wlUAKzvqu6oOlFSVgqSfqs/tah1Pcn0WphR5nIEY3I1PJTP1+b34Rpt3x/ConwS2
 f91bo4hQtMeUK45nOTtCrZLoLEkWF2Pv4h7qIYSB0a0nbqSYsGH+jCNuPSQk2+VzFqhd
 GXFH1zmhgRH+w8iPOgD9LNJTZ9MfIveLo0D8TTXNK5BIYGnB0mhbrCdR6vw0zngvmcOh
 zbzAw7rRkS39RExKaa6kF97X/bW7FbDqzsAHAFN/nB8EPd07rHduhchAKIb5YHskc+/+
 rB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750168301; x=1750773101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gTTHIoORgu9Bflu6BYfPSZiqqQzuwh+Addr9boq0Ofo=;
 b=SkvsR0XxaKu8n+hQ8J/FhVpX6tHnT7utqHymtEw2d9CZUg0VjFUY9eP5h8k4dYXdDl
 VWNQoidUPGVw64P5AY48rU5dcb9SFb0yGr2m6MLxP2H8fmI0n1hHGuTQUDyQqtIIE5W+
 NB59axbXwqah+H6WOwHp0DOPwzNabD+yplrIxfzeSh2Kaw7akWAcGkJxr7XBv57ghjUO
 No2ULBoxi2UxRSFIiWlNw5Rgwh+aYQ52jvZeZQX1Erv4jZKwXUMCmU+tMWMXA4InhlUM
 PzUE9Dq44kzJVV6/qe9nHxqnLIO23RS4ZuCNgvoyu/HAHYT85VFAOlaJPKSO1ezQO23k
 p0QQ==
X-Gm-Message-State: AOJu0Yxfi6g7rU1TXASQwlgOyiKF4MB1rGVd7jNXCMs4DLOf0b3fjsdJ
 VusXaxjPyybpO+kovv6NopFrwPqurny6L7VRzSZjtCY8jur0SDGbyWl/g7vqb6Auk4SqlmgBYjG
 pRHdv
X-Gm-Gg: ASbGncuXT2UJISVON6JdI1J2nu2p/GfJSqho8haF9WeKR3Iokm+1+qKFbafVrryzdxo
 4Nj6/N1mdUJxEd36cKjhwVXXpO2mn9oUy660WqGWiNDQEd1KuK9KCUcxiuE87stYALmgYdy7EZb
 W0Ejb09VWnFatcsPHfmSN/Kq+t7AXi9oq5+/FzbFkNR4998ICFuBMaYQWCB9qEwxbTWGmqnOHRd
 hj/ZlwlrhoH/d6aSen33IKMuYIiylFt1Yo22aQ8WVkJY2h2WcvXLjIPJKKiFJEpSzjs2Ao1xDvp
 5JLZLDJkj/how5EdmoKxYexjFKPr7ignc3enz9QxNz+HE0P9DlcKifJJwNo9WynriNjcNhj3mm0
 c7Jlm0J3DDfvDTNiTTSvFAemnks/9iY0HK/myHGeR/pz+clO35Q==
X-Google-Smtp-Source: AGHT+IEkj4411EpO3rrZQ37seBFh50GSgtvKDzc8A2PE0+q3nI2b83RIujU94JyChgXkBELJUyxK5A==
X-Received: by 2002:a05:6214:5884:b0:6fb:44a:3d36 with SMTP id
 6a1803df08f44-6fb4777845fmr214056076d6.20.1750168301257; 
 Tue, 17 Jun 2025 06:51:41 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb4fe7baaesm31391976d6.18.2025.06.17.06.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 06:51:41 -0700 (PDT)
Date: Tue, 17 Jun 2025 06:51:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, Somnath Kotur
 <somnath.kotur@broadcom.com>, Peter Spreadborough
 <peter.spreadborough@broadcom.com>, Farah Smith <farah.smith@broadcom.com>,
 Jay Ding <jay.ding@broadcom.com>, Shahaji Bhosle <sbhosle@broadcom.com>
Subject: Re: [PATCH] net/bnxt: fix free of not allocated object
Message-ID: <20250617065137.3d13a822@hermes.local>
In-Reply-To: <20250521193727.382342-1-stephen@networkplumber.org>
References: <20250521193727.382342-1-stephen@networkplumber.org>
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

On Wed, 21 May 2025 12:37:27 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> This was found as error when compiling with LTO.
> The function allocates new data with rte_zmalloc and then
> stores pointer in the pointer-to-pointer passed as argument.
> In the unwind case, it would call rte_free() with wrong one.
> 
> Fixes: 80317ff6adfd ("net/bnxt/tf_core: support Thor2")
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/bnxt/tf_core/v3/tfo.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/bnxt/tf_core/v3/tfo.c b/drivers/net/bnxt/tf_core/v3/tfo.c
> index bee813ebf6..c888dd1e4e 100644
> --- a/drivers/net/bnxt/tf_core/v3/tfo.c
> +++ b/drivers/net/bnxt/tf_core/v3/tfo.c
> @@ -74,9 +74,7 @@ void tfo_open(void **tfo, bool is_pf)
>  	rc = cfa_bld_mpc_bind(CFA_P70, &tfco->mpc_info);
>  	if (rc) {
>  		PMD_DRV_LOG_LINE(ERR, "MPC bind failed");
> -		rte_free(tfco);
> -		*tfo = NULL;
> -		return;
> +		goto cleanup;
>  	}
>  	if (is_pf) {
>  		/* Allocate TIM */
> @@ -104,8 +102,8 @@ void tfo_open(void **tfo, bool is_pf)
>  	return;
>  
>   cleanup:
> -	if (tfco != NULL)
> -		rte_free(tfo);
> +	rte_free(tfco);
> +	*tfo = NULL;
>  }
>  
>  void tfo_close(void **tfo)

Ping. This is a bug fix which seems to have gotten no response.
