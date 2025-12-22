Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B1DE67811
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Dec 2025 18:37:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 641F140265;
	Mon, 22 Dec 2025 19:37:10 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 71BB540264
 for <dev@dpdk.org>; Mon, 22 Dec 2025 19:37:09 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-477632d9326so25764095e9.1
 for <dev@dpdk.org>; Mon, 22 Dec 2025 10:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766428629;
 x=1767033429; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Clp0XXGACmMRPAquneTiq4hM0Z3+vFQMNhaQOBP2Xsk=;
 b=nVA+3AnhuAxJYwtjpoNsTGr4IAodi7MuD2Si+pxq08Xi6VMt5LSlbH8GPcuUaiL1ag
 qm4EPsjlio4i2/YW5vd4ITpnHyPk/dqtPFq/DV9K8ZyVrHsJpazrtnoDGvJwbCggoauN
 dnp/BckxYr2ZJ6DKRBIlsSj7UyAD2QzALgqPrwckIosofFPtXFDt6J4e8XcdJlbenV7D
 TOXb3asu+pv00ZU93177iJP0ltPWKEiUWWTGsFP6kNY+iV/1mjdsW1JLvnDwvVALPt2f
 MrqWJX2xCuIV92JMFZa/Ef1V1RGc9fipwjhbc5bHF76averNfYx3FH4Mf+UgeBD/qtlM
 dnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766428629; x=1767033429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Clp0XXGACmMRPAquneTiq4hM0Z3+vFQMNhaQOBP2Xsk=;
 b=kZmFTh1JpNyRVVPpyo0AAub1yGNEmC8DlGA6A/Zrb/Y+VHilKw1v+NfXuH3R+WB5O9
 3mybykOMV/WO1d09vUk4y4x5WOx2ZvgtCIeYdllHA0507RCFsjnHhb1U7pSgRjvdQwaI
 MmQlyv4mDMZPQU5tHf0rgormmYK1HEctqO156mYfxDLltliAwqhja6gWpFnyRPNtLmMR
 ZmDSXd2gsg6YgAg35DYDvskiQULj8FDeK6eiJqq+XN0ISzI2ihsoNsgfs2vlHq/78Y2A
 CDU36QtoupIWTnMFdUPhqr+zKljBI0jR+KQ1r2Bnl3Wot+G2QsZfvf7/S5g83n7JRvHO
 CvDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk2QgXXUIlJ4CmPDuWM1gdCrZpJh5nrRWwvV8+vDZnjEYc43DOIi/iMOizjGuchGntMgo=@dpdk.org
X-Gm-Message-State: AOJu0YwdsQF20szt3o+BZAFx69biQ0UID1ZFKNZgolSSBWyi3dJ73PhN
 bnl1gQWsrjloF5D8TdEi2CqnZUXamSIGYaidGAONX3YlE9HkLvoE4T2IkxbWlDEQ9yQ=
X-Gm-Gg: AY/fxX44e068iQBYyuG2EMSNT5cmlmXqEEqZQjvyj2tmVv/qPw2S4O1aNMxjkybPiZ7
 c4NMd4Da5eig6I8zfTnTwbsUYbApoD+k05CeTNe/fDqGIwKan1n10mjirBhSzKtxJm606rLBrPB
 hkq/DYwObZnYM8MUImuAZ4z77wpGO8dJwY9KuCXPVtmS5l2Xsq24Q4ZVuCfhvL8TitU/xTOGDUA
 l5vfWNMfVNMiMVRFFZ4jTOtXoQp9aFLMQD/2TluqNRaUBy9O/cqdPgwyuBk177pF3yjOxvpRTaQ
 AmIX2sEXwz1K9qC5CkE1DnYAI7YzB2rI+zawbGcXhUckgulhLKJX5sq8/WWWomo9N1Xvj4Fudj0
 X5TBkY8Je4VJZRFEZWQ/+CW2XzScOEbRGGkCGMxRvujRYVBNjmS4aV/GUcyi8VlA2vLmyVb7eRI
 LBu0tlroxHSc0ZQMqlSLsK4vznhPYYaDg6HAosSRrf7DN6TGMUTZVf
X-Google-Smtp-Source: AGHT+IEjko4QkrT4N9ogauDXUEEzjPPKPdqgOn78PzaimNluKLKQ8lkYkw+alEY0qKtt1Lt0QZ1Vbw==
X-Received: by 2002:a05:600c:620d:b0:47b:da85:b9ef with SMTP id
 5b1f17b1804b1-47d19569c23mr143190425e9.16.1766428628779; 
 Mon, 22 Dec 2025 10:37:08 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193d5372sm214190955e9.14.2025.12.22.10.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 10:37:08 -0800 (PST)
Date: Mon, 22 Dec 2025 10:37:03 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tianhao Zhang <zhang.tianhao2@zte.com.cn>
Cc: wang.junlong1@zte.com.cn, yang.yonggang@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v1 1/2] net/zxdh: add pcie bar channel check
Message-ID: <20251222103703.62096eea@phoenix.local>
In-Reply-To: <20251222102535.401064-2-zhang.tianhao2@zte.com.cn>
References: <20251209021609.3911854-1-zhang.tianhao2@zte.com.cn>
 <20251222102535.401064-1-zhang.tianhao2@zte.com.cn>
 <20251222102535.401064-2-zhang.tianhao2@zte.com.cn>
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

On Mon, 22 Dec 2025 18:25:34 +0800
Tianhao Zhang <zhang.tianhao2@zte.com.cn> wrote:

> Add pcie bar channel check after getting dtb space left.
> 
> Signed-off-by: Tianhao Zhang <zhang.tianhao2@zte.com.cn>
> ---
>  drivers/net/zxdh/zxdh_np.c | 7 +++++++
>  drivers/net/zxdh/zxdh_np.h | 2 ++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/net/zxdh/zxdh_np.c b/drivers/net/zxdh/zxdh_np.c
> index 024da113e2..4e2637e1b6 100644
> --- a/drivers/net/zxdh/zxdh_np.c
> +++ b/drivers/net/zxdh/zxdh_np.c
> @@ -3698,6 +3698,13 @@ zxdh_np_dtb_queue_unused_item_num_get(uint32_t dev_id,
>  	rc = zxdh_np_reg_read(dev_id, ZXDH_DTB_INFO_QUEUE_BUF_SPACE,
>  		0, queue_id, p_item_num);
>  	ZXDH_COMM_CHECK_DEV_RC(dev_id, rc, "dpp_reg_read");
> +
> +	if((*p_item_num & ZXDH_DTB_SPACE_LEFT_MASK) == ZXDH_DTB_SPACE_LEFT_MASK)
> +    {
> +		PMD_DRV_LOG(ERR, "pcie bar abnormal, get dtb space left false.");
> +        return ZXDH_RC_DTB_BAR_ABNORMAL;
> +    }
> +	
>  	return rc;
>  }
>  

The DPDK style is like the Linux kernel coding style, the bracket should be on the if() line.
The indentation is also off.

It is also not clear what "space left" means, could you provide a clearer message.
