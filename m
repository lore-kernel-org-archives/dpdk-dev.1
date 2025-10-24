Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4395CCCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 22:14:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 574534021E;
	Sat, 25 Oct 2025 00:14:08 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id 1506F4014F
 for <dev@dpdk.org>; Sat, 25 Oct 2025 00:14:07 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-7a226a0798cso2206962b3a.2
 for <dev@dpdk.org>; Fri, 24 Oct 2025 15:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761344046;
 x=1761948846; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VQps6fZlntD20vPfBopJum/kfdUA/1dlxMD4hJv/46c=;
 b=hBtf8KNWyOCFWjiTs5wOfKmmi3D5TvZHqx7Z/xPJgtbuztrK/CawjzedNFSm6czmp5
 uV2JnCJ00eBEDsOC6MpMvpZpJ0c5u9Wk0EY+CBOTHdhfZrQv5UuH33RYIyB7zDUwm4KH
 JiK9lkSqFlFc6fniPw1lynuSwNMxpF6Xi388YVshj4l5O0UtAsbkUJ5x0NwooOxrPwBt
 eJ0o1Q9UPoxUQzL4FpK2gp7AN9x6hWH3OtRJUMFtiBCIjxbRGkPbc4SiKbSFnvs9dm+A
 X1nXZ7yxrBtXvU6Rqzf1cVQwAPIeavYXgSSNHpQEJI9Jnq4Iw+0DiEOpsHAGsAB7HOA1
 rPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761344046; x=1761948846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VQps6fZlntD20vPfBopJum/kfdUA/1dlxMD4hJv/46c=;
 b=WesSWCbzGMRHbMyHEn7XYzIWUdj3xd3AqhkiRwsQk027QSvllaJ1+9NuqwWupWmhGB
 Izjrv+2y0gf03bgm3CyW1P4/jWw/q9PXYyLnfRaT/eDV6i9ggq/NKOGxW2+TlkuYAWiV
 M67y3XLqm8POlCd4cduqkdJDEl2rLcvGVt3D8406l3pjLkyyCDyPV7AVCRLSUaEt6Hsh
 yzpva5Fp5nqXZVEXDZPBg6J4dIe18jWQp+Xi4DoC2B6mHXAsI607ZGoH7pONCHrTtlOm
 NrhvahDpdMgtY23CIqepsAwFedjIlF2nyiaEZzFRXtNxTnXS5FjY0ghQAZZWpFJZobpu
 pceg==
X-Gm-Message-State: AOJu0Yxk1J/ud+tgfSKuUk7WzgkgrGKopTDvQSYK8c0SETT/3OAwxRjk
 SI5QMq3yDjCoqPLk9+kSKF8LYQ963j5xC/qRfI4gkvWtUMBB5rZ1I7hPZx6T3Ue3MLALa/h1gap
 whj17
X-Gm-Gg: ASbGncsDvUTdnfiVXdkdkdLTSldvyF30svh1kShnDvdCHGCVwqWaw2E4nNmVhJNKXfy
 3835PAXMJxdVtogOH3r1SC+7zWmcYCDs99AN9C7tci4UcaO++NWMkyJZ4BOC38irYwKTyTvyCUB
 3Mr5mtlAP9PZLHwcdUNE3JFpUGSmJlFHadwqgF6bzhwCJ6Ueg3+WDJhDzjyXCvHU2BEL/X4kr7r
 iBdmwO8cO1RSvv0QTmtWn5FNKAEY7Q7rmIMZjnUrKDe5Oq2HGx0D/xZNEPPF5cq7SkOOeOUB2CB
 N89vcn021CDDnaNxEWPaUvqp8yd8sYzfmpSFq81FG8t2WvzXkUuj6i7RFoiSTZEFa13FvlXvPkD
 GE5mUHMHu0MNK4PC6P2KXUovZNUslqHVaX6e9nJin0DZSlg7AOHQJGGmErNQZRWLeA28bCDtouo
 LhrEpPRwX2OgXxqosKaXnCJma0k22Fy+wCeA==
X-Google-Smtp-Source: AGHT+IFPic56ircQjqTVLN3Y62k0KUrjmCxSjYjn+BlVwuCGaWVkIlDRninGUqVRbo6nFjvROuXxig==
X-Received: by 2002:aa7:888e:0:b0:77f:4f3f:bfda with SMTP id
 d2e1a72fcca58-7a220b25969mr34513789b3a.31.1761344046048; 
 Fri, 24 Oct 2025 15:14:06 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a4140168f7sm273986b3a.11.2025.10.24.15.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 15:14:05 -0700 (PDT)
Date: Fri, 24 Oct 2025 15:14:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v12 02/13] net/sxe: add ethdev probe and remove
Message-ID: <20251024151404.11679c98@phoenix>
In-Reply-To: <20250728090517.1811244-2-liujie5@linkdatatechnology.com>
References: <20250725104855.73326-13-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-1-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-2-liujie5@linkdatatechnology.com>
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

On Mon, 28 Jul 2025 17:05:06 +0800
liujie5@linkdatatechnology.com wrote:

> +static s32 sxe_dev_start(struct rte_eth_dev *dev)
> +{
> +	s32 ret;
> +	struct sxe_adapter *adapter = dev->data->dev_private;
> +	struct sxe_hw *hw = &adapter->hw;
> +	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
> +	struct rte_intr_handle *handle = SXE_PCI_INTR_HANDLE(pci_dev);
> +	struct sxe_irq_context *irq = &adapter->irq_ctxt;
> +
> +	ret = sxe_fw_time_sync(hw);
> +
> +	rte_intr_disable(handle);
> +
> +	ret = sxe_hw_reset(hw);
> +	if (ret < 0) {
> +		PMD_LOG_ERR(INIT, "hw init failed, ret=%d", ret);
> +		goto l_end;
> +	}
> +
> +	sxe_hw_start(hw);
> +
> +	ret = sxe_irq_configure(dev);
> +	if (ret) {
> +		PMD_LOG_ERR(INIT, "irq config fail.");
> +		goto l_error;
> +	}
> +
> +l_end:
> +	return ret;
> +
> +l_error:
> +	PMD_LOG_ERR(INIT, "dev start err, ret=%d", ret);
> +	sxe_irq_vec_free(handle);
> +	ret = -EIO;
> +	goto l_end;
> +}
> +

Since this device is supporting per-queue start/stop, it should support defer_start.
The semantic in DPDK is that when device is started, all non defered queues should be
auto started. Looks like this driver is assuming application will call tx/rx_queue_start
on each queue.
