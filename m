Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBA1FD8FF5
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 19:09:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAAD44027F;
	Thu, 26 Feb 2026 20:09:39 +0100 (CET)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by mails.dpdk.org (Postfix) with ESMTP id 1F19F400D6
 for <dev@dpdk.org>; Thu, 26 Feb 2026 20:09:38 +0100 (CET)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-1271195d2a7so1916048c88.0
 for <dev@dpdk.org>; Thu, 26 Feb 2026 11:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772132977;
 x=1772737777; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qvgp0O4YWZv+r0j5zMHsKK22fhHjfyCQ1oo37KITyrU=;
 b=PrvBRLoyYTaExEQpz37HBW052MI/IEd/6bAinIIPNFoYBxjMs5wr3ef9k1J/rb5fvO
 lVHjLlh6hzYeO4Iuj7s9crdQp4TBi3leCd4oyw76yxRTxf/YimmZHg86smekbZ9EJt7o
 /38mVGDq3gpS4xrCfj+cLOJ8jdiGC5DWdwbkmu8V5edCUhiKzauP39rPk8hTi2UwS9jo
 qyC5H2yYFI3sUIWCK6KzduvriSa3yfid7i/dMOhJw4PYTAUmt7JQLgl/eIYbdwEN4DB6
 E7h09E02LbbWkvSkJoDQQx8iBHCoIxCdZwpu4zFByrSkE95Cmm4VnQtpaLHqLHUMDI8y
 QpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772132977; x=1772737777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qvgp0O4YWZv+r0j5zMHsKK22fhHjfyCQ1oo37KITyrU=;
 b=ZLp43P5h3/iBukLNvN5OHbTvKti9MKjg7UBe8AZOu4Cyz1eGprWZ7Q1jg6MIP+FUck
 Ub+OcFV3FubGd4XBIDQmv35fHzDtv0JqJ9uP7mvKIbIg6SPVyvw4yCY0s6XLGoF+m9DZ
 xB+f9sAVaoUgVVyuzINKOo2Nrrd2wd7Nv2INQ7LKKKwXQCeXJKNfKdll4WjUZM7KiLlg
 WGLgekXFARdFR6c1ySN2yozGjregUNbHxLAgAUtbSwZ/RgMO44O2YlBRCohWFpr8ARM0
 j5kGkKl4mObhDtGsEMLw5CmmvXbzVGM4CFWFhiepxNoON19t85AbmfKlYyicjiCgox58
 E6fQ==
X-Gm-Message-State: AOJu0YyXMz0clQRbo7xakYHlF4LScVSCmzqwq8PHgj+IiE3V8oy0x9Zn
 pkjOLsvmcJVKUN1rMIxjCmE5kmwEGtZ7XxWqLM+IRymG/CQqaBMHfTY1/4iSTIBage0=
X-Gm-Gg: ATEYQzz2X2Nhksz7EeEGrMovTiof5iTsrWS8AcOIa4RMqkJrEWHfc6ZuGIaJIm7lTOM
 OdwtVypSedsnklXd11TSAO2NFxf8tj5N4XCyoVBby1R8F27ECE+UfMO7bFLGILiL+uL15uZ2gOq
 k+Hpqt6GySzdD7om3aea924CdJOM3NlNk3AG+c68cnU3/MX79P4KNOnonNl1wrJsNV04a0+dWK6
 waxuDKOk9ExMLl5ueWMlnz1opEJo2ffygwUkDPe3HQiiqVr185xuX9NHNR+hCUPe7JBQM+IxVRx
 KZPf4SEdR5Xt+LG1ElthNycTLDcxN4ZOFEH3hnHvy06eCrE1m3D2p1WX3qSOvCo8NYs4uJxhSZY
 iwbuf+H5EfVBENoZJ2rUbdMnznaVecF8ug29nqkdwmtgsKxZZ50b53UmNLoRbI7Rm1AJq9PiKZg
 swxFB59ACYy1KpVTW569mIllovsUI3I1pHAIdXMEXEAYJBN0FzLewKHOtuleTby7/b
X-Received: by 2002:a05:7022:e0a:b0:127:3915:76b2 with SMTP id
 a92af1059eb24-1278fcf48f7mr2395c88.27.1772132976966; 
 Thu, 26 Feb 2026 11:09:36 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-127899d49c1sm4104606c88.1.2026.02.26.11.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 11:09:36 -0800 (PST)
Date: Thu, 26 Feb 2026 11:09:33 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
Cc: <dev@dpdk.org>, <Selwin.Sebastian@amd.com>
Subject: Re: [PATCH v3 1/3] net/axgbe: add external PHY read/write functions
Message-ID: <20260226110933.1b5758ff@phoenix.local>
In-Reply-To: <20260226164638.1381-1-ashokkumar.natarajan@amd.com>
References: <20260225124456.1871-1-ashokkumar.natarajan@amd.com>
 <20260226164638.1381-1-ashokkumar.natarajan@amd.com>
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

On Thu, 26 Feb 2026 22:16:36 +0530
Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com> wrote:

> +	ret = pdata->hw_if.read_ext_mii_regs_c22(pdata,
> +			phy_data->mdio_addr, reg, value);
> +	if (ret)
> +		PMD_DRV_LOG_LINE(ERR, "mdio read failed %s",
> +				strerror(ret));

Shouldn't this be strerror(-ret) here?
It looks like the driver uses the negative errno values to indicate errors.
