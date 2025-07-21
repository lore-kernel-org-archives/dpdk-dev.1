Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D940C83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 15:32:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F437402E2;
	Mon, 21 Jul 2025 17:32:42 +0200 (CEST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTP id 42D6740297
 for <dev@dpdk.org>; Mon, 21 Jul 2025 17:32:41 +0200 (CEST)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-4ab3fb340e7so84244611cf.1
 for <dev@dpdk.org>; Mon, 21 Jul 2025 08:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753111960;
 x=1753716760; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L/tReUMTLWadhEIZ8kZR45UGtJcbi3FgvBSFG9dH7xI=;
 b=wnuF+N9YnRBN5cRbIxPiN1ZjFKSe+MvtZB0XNTzq8rk7ngvd2caW58a9oq+qCGq0si
 8teQCwVZB+XqofaJEhW4ttdE7EuBlWIGGLksCzsTX2+v2/QBl2t9hcVZHFQS0uxfgBvE
 9LOuvOXemhQZCqtAkCztp9jejMod7P0FpLr9smpp/iEESB9SKur0aIE8ZMaklGVAuZnt
 KwAH5J3b9JPn4AMx4UHNofhUuWSuaZCeZxFFJxEOrJeeh23eAx/Lr0AeQyigiElNXOJ/
 mp3XxrCv/fprU+dN79q9yhsclQfhGG/uDR54kOBgB/xq05Z9ru9x45pDZ0WcyBQ+ilLM
 gkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753111960; x=1753716760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L/tReUMTLWadhEIZ8kZR45UGtJcbi3FgvBSFG9dH7xI=;
 b=mJhbg2RmjUirCAoH84whURQCwUFvFkZeKlyWvABrXeCmQKqMKW69uhmXfGHYPuA/ih
 ah33BeQZuFqcLTRhR4rM2Y2L+36yM2fTlL7qvrJd/8R7+5QLZGU40KflMVhAaLIkgIlM
 2rpfMyuosEMebFIsC5baPgDz2ogRpxafyMAZpNyPmkYkaFe4Eqt9YmXipIZug2UVWZVC
 p9FRsPi8XiA3DG1ogS8hu2AQw+ZEF/D/ljhDDhHRugFntVdR0V2YhTsMt8RrKzWNIqPM
 yvB3TrFvS1cAu3dQvWWThSWv4MOx5XmpfQsCviKhkCIZVr+epps4jfmDrKzcDxjuVaYg
 tVjg==
X-Gm-Message-State: AOJu0Ywwc1oEjlsBa3VSc8AIeLbJZh7VKzxP62OY1B01d4Hy3/W+ITNp
 GTZl3+p58x290n0uASNVWJg657BEov7QtgfUlCNTOIp0MavNO3B6LIreAr7KNCYmGMnZFVrRNjo
 HWYmx
X-Gm-Gg: ASbGnctmrKHWGQg/n/AN3VLi6rVVVouauaSswo/Q03ZHoMBH+faGGiVAFECzHe7J49K
 q10shYX8pu+8ny+bHlSwko3cEmQ1ujvdKCXgIVBLo/lDZXhcPedC6kxuhLKiru7g5y0/bPWstXR
 Jexzb12u6f7rbymZ2oMz07cvdY1cPeLG6mMCdu++h/Q0DMR+ojnacpkDVrTnkXlKkF/M7ma2Ix8
 zTq79ONK18ggEQQ1ktaBjRiB4HscmGVwDEuZWRA7sR4p1y/mGo4jsad5MFxa05sWlcKCUY7T6Wv
 +YPrMrCqL7exbUEi5W/Tal6Jow7BpfL509Sj5RuONKREYkyF2dllQAWexmezObNFgTskR67YM3c
 2TSVCY3EDt0jAjVsFQgFgO3SmeNBCnFQe6intrZVh0ehCQ9GAbe5ilahLrJHMOg+34LhLcRlq/7
 0=
X-Google-Smtp-Source: AGHT+IEbzmwmGSFzUXWtx1beK36K1kfQ7+ZySQicjXVpLsyG/E0vpjcBwlZP3xFRS0F7TantewWwAg==
X-Received: by 2002:a05:6214:2421:b0:701:945:68a0 with SMTP id
 6a1803df08f44-7051a11473amr225658806d6.26.1753111960316; 
 Mon, 21 Jul 2025 08:32:40 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7051b8e0512sm40674876d6.28.2025.07.21.08.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 08:32:40 -0700 (PDT)
Date: Mon, 21 Jul 2025 08:32:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v10 10/14] net/sxe: add xstats function
Message-ID: <20250721083237.1031fbda@hermes.local>
In-Reply-To: <20250719090537.699357-10-liujie5@linkdatatechnology.com>
References: <20250716082930.83026-14-liujie5@linkdatatechnology.com>
 <20250719090537.699357-1-liujie5@linkdatatechnology.com>
 <20250719090537.699357-10-liujie5@linkdatatechnology.com>
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

On Sat, 19 Jul 2025 17:05:33 +0800
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> +s32 sxe_eth_stats_get(struct rte_eth_dev *eth_dev,
> +				struct rte_eth_stats *stats)
> +{
> +	struct sxe_adapter *adapter = eth_dev->data->dev_private;
> +	struct sxe_stats_info *stats_info = &adapter->stats_info;
> +	struct sxe_hw *hw = &adapter->hw;
> +	u32 i;
> +	u64 rx_packets = 0;
> +	u64 rx_bytes = 0;
> +	s32 ret = 0;
> +
> +	sxe_hw_stats_get(hw, &stats_info->hw_stats);
> +
> +	if (stats == NULL) {
> +		ret = -EINVAL;
> +		PMD_LOG_ERR(DRV, "input param stats is null.");
> +		goto l_out;
> +	}
> +

This check is bad in two ways:
  1. You already derefenced the pointer stats in previous line.
     Coverity and other static tools will report this as an error.
  2. The only thing that should call sxe_eth_stats_get is from rte_Eth_stats_get
     which already checks for NULL.

      
