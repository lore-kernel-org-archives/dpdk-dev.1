Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C525C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 18:25:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89A5E406B4;
	Mon, 10 Feb 2025 19:24:44 +0100 (CET)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 3E56D402DA
 for <dev@dpdk.org>; Mon, 10 Feb 2025 19:24:43 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2fa1e25e337so5684286a91.1
 for <dev@dpdk.org>; Mon, 10 Feb 2025 10:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739211882;
 x=1739816682; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VxF1sKqelE4x9rbCR6OcgeklpKOMFwYTgnd2oFiF4HY=;
 b=Q/9bpsGl3+AK31dS49HYuFCSoMw5yp5bPulQCNfJJO7IGfKjUsx/S5VJopZKtu7mbE
 obCRhArQXlqBHSk7b5cCHqEHPObbHP+5pfsUR+UxAjaZSTOf4zDtIZneJqWMc2WBtBAB
 q955GEkQ0dgYPOzhtDOk0gyu94jQH3GNsUIIv6MQ/NpnYZXZLnuobCLijS3lwQ9cZqC1
 IIjM4OOgGTSMW5k9DJ01MQeXNX18Iwl6V6uRlpfycmLhiorslgTwPdflYOVmiTun5VTc
 S0pMMHlb7JLNPmwmsKRn5GSQjn69obWpSOqhmH23xsxIYgP30VOCcxYXMiC/7e8Qoh/D
 I6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739211882; x=1739816682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VxF1sKqelE4x9rbCR6OcgeklpKOMFwYTgnd2oFiF4HY=;
 b=Wk8F5ykI8QZneXstvABXY6OM8204fHrGOUfUjhR8vWcbXrUlQn+yilvGhbTGDHIv0k
 784YA9mTNdneYvvFXgFGc4LpHphAQLwB/753sm2xCot6+FTsLC8sGBISo7+JvxVdR4wE
 L0FDPNe9RU3EqtjiIdhatNUmPQC9z1HHtECK811FL00W+jPYAyU2GbuZBEswzj/+0QGa
 1HSHfhNtPOH+lXcijv1ef2YKuF14v3nD18jFO6TSPCNhEQa6EE0Rf5MmzFxgVEOuC04Y
 3AnZhOcU94PL2bIDdPvPURQwvC5vpLUtgeJQ2DjvUNGbWv36L2joaJcJr+oDnogBlHyu
 ceJw==
X-Gm-Message-State: AOJu0Yzwsd0F/nx7teYKvL9qQ6tB5fWkuFbLEY28TTLTwhvPqH7t3oP2
 BEUXlRc51tmZwtP1bH+Lh6WQbZLFhs3extG73s65Xn6ziBkgxwBq6TVihHLe0qUEfQZgyhRwy3A
 r
X-Gm-Gg: ASbGncuJZCnPEYyStLBA6Vh8/jNkHQj9ljSPIb7McuGk4WO+yHG2FnsaLvqEjyStLxu
 rHWIG3oxOWsdLI0ospizHMYFEyTslOSAnh9vQw8sUfxHA9i0A8SmofwfHY4MHT7KyYhsoxi/wLa
 c3QqZGxb+wWInGCQtWoTmopW/TWJRabhLiQxt0mED3KJKQI81Yi0UjibKjIRslS8YWlDKuIm/Px
 K0RY2WniscO9gxiBGWz2ICnBiubscFP4Md+qw8Nma2JOTzO9n2qIatwB9+m4/WCDoo0wSBskjWt
 ueVJ00b0MEZY0K2jC/iWfF9SAtNnkfvHaDqyM5b/6gsIH3KVpmJDRRQNlARZ59sXNven
X-Google-Smtp-Source: AGHT+IGy5FtOITUpM9MAaLqRYVzz0UVKu9Fm1H8Pt/Yo0a8xctR8XdnQ+J4fAxyBPGyln4Cty6gY4w==
X-Received: by 2002:a17:90b:1b44:b0:2ee:bc1d:f98b with SMTP id
 98e67ed59e1d1-2fa243ed3dcmr20082986a91.31.1739211882412; 
 Mon, 10 Feb 2025 10:24:42 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa42dde5e5sm5519217a91.3.2025.02.10.10.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 10:24:42 -0800 (PST)
Date: Mon, 10 Feb 2025 10:23:28 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 03/14] net/zxdh: add agent channel
Message-ID: <20250210102328.46478bab@hermes.local>
In-Reply-To: <20250210014702.4105460-1-chen.bingbin@zte.com.cn>
References: <20250210014441.4105335-1-chen.bingbin@zte.com.cn>
 <20250210014702.4105460-1-chen.bingbin@zte.com.cn>
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

On Mon, 10 Feb 2025 09:47:02 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> Add agent channel to access (np)network processor registers
> that are not mapped by PCIE.
> 
> Signed-off-by: Bingbin Chen <chen.bingbin@zte.com.cn>
> ---
>  drivers/net/zxdh/zxdh_np.c | 481 ++++++++++++++++++++++++++++++++++++-
>  drivers/net/zxdh/zxdh_np.h |  77 ++++++
>  2 files changed, 557 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/zxdh/zxdh_np.c b/drivers/net/zxdh/zxdh_np.c
> index 538e3829aa..bab8b23a68 100644
> --- a/drivers/net/zxdh/zxdh_np.c
> +++ b/drivers/net/zxdh/zxdh_np.c
> @@ -13,6 +13,7 @@
>  
>  #include "zxdh_np.h"
>  #include "zxdh_logs.h"
> +#include "zxdh_msg.h"
>  
>  static ZXDH_DEV_MGR_T g_dev_mgr;
>  static ZXDH_SDT_MGR_T g_sdt_mgr;
> @@ -234,6 +235,21 @@ do {\
>  	} \
>  } while (0)
>  
> +#define ZXDH_COMM_CHECK_DEV_RC_UNLOCK(dev_id, rc, becall, mutex)\
> +do {\
> +	uint32_t temp_rc = rc;\
> +	if ((temp_rc) != ZXDH_OK) {\
> +		PMD_DRV_LOG(ERR, "ZXDH %s:%d [ErrorCode:0x%x]!-- %s"\
> +			"Call %s Fail!", __FILE__, __LINE__, temp_rc, __func__, becall);\
> +		if (zxdh_np_comm_mutex_unlock(mutex) != 0) {   \
> +			PMD_DRV_LOG(ERR, "File: [%s], Function:[%s], Line:%u mutex"\
> +				"unlock failed!-->Return ERROR",\
> +				__FILE__, __func__, __LINE__);\
> +		}   \
> +		RTE_ASSERT(0);\
> +	} \
> +} while (0)
> +
>  #define ZXDH_COMM_CHECK_POINT_NO_ASSERT(point)\
>  do {\
>  	if ((point) == NULL) {\
> @@ -330,6 +346,66 @@ zxdh_np_comm_convert32(uint32_t dw_data)
>  #define ZXDH_DTB_QUEUE_INIT_FLAG_GET(DEV_ID, QUEUE_ID)       \
>  		(p_dpp_dtb_mgr[(DEV_ID)]->queue_info[(QUEUE_ID)].init_flag)
>  
> +static uint32_t
> +zxdh_np_comm_mutex_create(ZXDH_MUTEX_T *p_mutex)
> +{
> +	int32_t rc = 0;
> +
> +	rc = pthread_mutex_init(&p_mutex->mutex, NULL);
> +	if (rc != 0) {
> +		PMD_DRV_LOG(ERR, "ErrCode[ 0x%x ]: Create mutex failed",
> +			ZXDH_MUTEX_LOCK_INIT_FAIL);
> +		return ZXDH_MUTEX_LOCK_INIT_FAIL;
> +	}
> +
> +	return ZXDH_OK;
> +}


Why do you need a pthread mutex versus one of the other existing DPDK locking primitives.
A pthread_mutex is slower, has more errors to check, and is not portable.

The one reason would be if you are trying to synchronize something that is slow (might sleep)
or with an external non-DPDK program
