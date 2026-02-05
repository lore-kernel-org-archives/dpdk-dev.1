Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAF2ECD983
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 16:46:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 408B240684;
	Thu,  5 Feb 2026 17:46:32 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 6AC23402E6
 for <dev@dpdk.org>; Thu,  5 Feb 2026 17:46:30 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4801c2fae63so9105165e9.2
 for <dev@dpdk.org>; Thu, 05 Feb 2026 08:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770309990;
 x=1770914790; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3Uf+18dTat1fFfTfUGMatAAHUADpNCUNDw1OlouJB4=;
 b=glFgXgKpubhgOXzMdj81l/O6T8N9uWqyRyprDpUJKdUoPvxJd2d5MMxOrqDwqHTF42
 6gWDG4Mjy67waSv8HfHN7cnTGD+ad5/evh+M7yhQ6ZFXQLMIzbymuxTov22YFRIwlM9J
 ihcTZHxy6/T4WyO8w5ZnKYxzj7rGwGhhESBDpmlR0H7wwDSoJliXeOXMJqUFwW4g92Xa
 fUZ4DSj93g7In8KcMy9jeyFLvCfJpwLdzGypaYO/bSAs8112Dr1ZbXUrMdCej7eze55E
 T4/2defqPavI8x8GznjlHiVhRSMKCa7zkLAKFcWVxHbcwC//EVUUQ4X6icaRwCGUlBML
 2iRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770309990; x=1770914790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e3Uf+18dTat1fFfTfUGMatAAHUADpNCUNDw1OlouJB4=;
 b=VzKz1Nb0LedgsTrtua8QPIa+eZBI4klTjGE4pOJQyONwOVUKXBDEA3nvmacRgqkqoZ
 yfZbDFu2JfSuUU/DfdwR5MMRhiMtz+94FNYCw7rYRzrw1prmT3fGoa9TYTbHZtLQKVNP
 7gXTsxpeJA97JZA4GB5N+/kbQtm3fuBpJqzbtQov3NgiWlvgT/ljgbxPxGAXB1OQYE6J
 ESQv7qwR42ZjO8+M5Lhk7+vw9D6cAr6g2AaYoDnxVhO0gPf5ny4hTcdr4ySZvqpD2vlV
 Kt74lTsMCZZULGxdWAKCsyq9NIJJxHhEMfQpp2hiGzSUt8FsVXlKaRMCGyHcNTRpohxw
 JHbg==
X-Gm-Message-State: AOJu0YzNmWVGT12XdHgShgAlUvtL8CE/YNzeBYyyATE15Tg+qMVq/S3w
 EXR7/TC59D4fhPlggupa3JO4x146fsHhglYRJAgR6mifwGi44rwnJjMImxaXemQJrhU=
X-Gm-Gg: AZuq6aLe5sBWYvjVRZxHJntcE+cM4C0KGpSI7DMylB3T9VXIaAj4oJ4hGaPcvzQrNxn
 zx0n7PP0XwqHUcHT5r1JQm/3O/zbdxHC+xcxXlXtneAvLnwJFRIzHHqdF2Z+hy7t2HeL2l591ND
 PuzdixYTgSxKT5JqTNI6R62Dygc2WHql93nPrMwQGOaLi6RMyft94cugiIfRAEV+5ilX4cl0flg
 PUyoFEyOCZo03gcjWPHaL+dfZNwD7vwytl0LrUAVmCfzD7iW5hbJAgVqCG96h8cxjVm4tNsYu+j
 MPTqWRMdAZ6OapKojPDROhdludEI1bfO+nf0l4oDshomtHy8nrJZjGJBOlaB8Y0d516U9SfBvfg
 jscF5AyHSEa3Lds5LVCY9WctUwKsgERlkkHnmKhiNRJKmznOqMfYpPf/8I/I7ztlsvcMD+mZoEJ
 G+xhje65Sw0qV+V+dxTcXH2x8CTUubc2JRQmOTzSpe+R81e0xfVFG1
X-Received: by 2002:a05:600c:4e48:b0:47a:935f:618e with SMTP id
 5b1f17b1804b1-483201dd428mr277255e9.15.1770309989875; 
 Thu, 05 Feb 2026 08:46:29 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830ec53159sm47622715e9.4.2026.02.05.08.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 08:46:29 -0800 (PST)
Date: Thu, 5 Feb 2026 08:46:24 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: malikovyehor@gmail.com
Cc: dev@dpdk.org, maxime.coquelin@redhat.com, chenbox@nvidia.com, Yehor
 Malikov <Yehor.Malikov@solidigm.com>
Subject: Re: [PATCH v2] vhost: fix use-after-free in fdset during shutdown
Message-ID: <20260205084624.1a733c7a@phoenix.local>
In-Reply-To: <20260204184011.8722-1-Yehor.Malikov@solidigm.com>
References: <20260204184011.8722-1-Yehor.Malikov@solidigm.com>
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

On Wed,  4 Feb 2026 19:40:11 +0100
malikovyehor@gmail.com wrote:

> diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c
> index 9b4f332f94..e953dd1849 100644
> --- a/lib/vhost/socket.c
> +++ b/lib/vhost/socket.c
> @@ -1209,3 +1209,11 @@ rte_vhost_driver_start(const char *path)
>  	else
>  		return vhost_user_start_client(vsocket);
>  }
> +
> +RTE_FINI(vhost_user_fdset_fini)
> +{
> +	if (vhost_user.fdset != NULL) {
> +		fdset_deinit(vhost_user.fdset);
> +		vhost_user.fdset = NULL;
> +	}
> +}

NAK
This should be done as via rte_eal_cleanup.
Did you not see previous analysis?
