Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5479CC61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 15:22:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6B1F410FB;
	Mon,  9 Jun 2025 17:22:02 +0200 (CEST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id 9C9D5410FA
 for <dev@dpdk.org>; Mon,  9 Jun 2025 17:22:00 +0200 (CEST)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-7d3862646eeso107728085a.2
 for <dev@dpdk.org>; Mon, 09 Jun 2025 08:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749482520;
 x=1750087320; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/MEUNI5tQ9qm1ipd8S2d8rL/ObAOKufCofu+HjN3ZsQ=;
 b=NVz36zW2xmm9DW/xRZkZ2qNvGRn5x//H6t6zVdZuRqwX4qGFi5pj0AajwAsV0D6eDC
 XbgNqW/vA+yPWHjiNJQ82hLxkIut9k68Z5GFreaabVDmyftp/57W64uySWW5l2XbWQEU
 FpPCQckrgOmwJidA0gcXYMVLeEbtAr5M9ldFglBDuBBvmUBQg+Khzo4rIZdqabMISlps
 e1Wr0Uw106UyCwaQAxyY6Ym6t4TfHCqr9pU+V5OjnulZxkkbjRblc+GuRfKRN9jIK0vm
 owkRFXFjukGdjjJSd+ocm0OoqX+pQXsQ5Uwk5VGR+hx8hZkOs3jeJxLzWD+bHlRvPnG8
 MOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749482520; x=1750087320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/MEUNI5tQ9qm1ipd8S2d8rL/ObAOKufCofu+HjN3ZsQ=;
 b=c2r9fabcIOFIeoFFZy1NX8olzpbCheYpcQQ1xMqHIm5tLCoaU+JvX2RS9GJaQl/LWA
 jM2mhIozRrrpwFLFkkMzV2w5vnyhCetbEDL0Sb6k8R11SFuoQqQYzGXWlJrPtRf36yuW
 9HWlGY/JTw9gJ8p4+PF2Pv3VyWua1MPKAj+RxT3NVI5ZdRSLHOdWJl5TVhRKzvD/7ZBP
 4xUQjsqjTiUbLda8+XRXKfkbJUASrX0RmPrbZVkyQCSo22Gc2BtqkHDimleU/QDSUnQ7
 RYKtZ8fQ6RkIQzBpSLJT9jd9MvW5nmURa7Awo0vKDUWfyPxoUaSAurZMX6fBdSAjczCo
 YEdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeX5UFcGKObHYnnSIneGtoAvsWau8q7ybJ96wSRLrxDHmNDMzoF44lZ6QcRjlfg+2zYlw=@dpdk.org
X-Gm-Message-State: AOJu0Yyfqu/AcGrFq5CveHq8a/NC9W0a/Rn9ScNnvLr4rcGXlf3iLnv4
 GnQKx1LWdt/xfK9Nedn9XCiimAoxW2gPeDX+c4OOYKWPLF/Pb60vE+BCvnjvflIOXs0=
X-Gm-Gg: ASbGncu7QWqrTv85uavhb83haiKT98K8Y+xFKRc28iR7JL4QRvY7AtCJoe1NBFJ633t
 VewSOOWRlfFNfEfVayYA61ZZHTiluDs1IYFiANMvRGeog0scW9Ssz+oxtkqS49Pth0E21hRprbH
 wN9ZYCaSb1sn8eiJJJqwBK2bMeQ5jlVCOTu2hO2dHILOnFEwTZutGmf0K7dxIBSIXJPi8/9ggw1
 5DmoiIxdtc0bax0QtEDmgMWMVc+kb9TJcvW5BbTResyo19ShWbiE4kPpu/Iasa8nL3yj7NMD+aE
 KwuB+qD1SZDFsjy5y0w/0yxxOryyJahYDSMhwlysWwZyuDcVL865U8L7jOSGb148qvYZJMYy7rP
 ddu0lB11/yEDa1MS2Yt0LHfA3az7lV4ocZyd15Uc=
X-Google-Smtp-Source: AGHT+IGAK99DshkOmm8LNAa52VFMh2I0yTDnDBLhZ6tNBWemY+rRmiB3QCLRp5c61T4bRlFOYiAvlA==
X-Received: by 2002:a05:620a:f14:b0:7d0:9ffd:423e with SMTP id
 af79cd13be357-7d22995c5a5mr1982805585a.13.1749482519846; 
 Mon, 09 Jun 2025 08:21:59 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d25a535889sm559467785a.28.2025.06.09.08.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 08:21:59 -0700 (PDT)
Date: Mon, 9 Jun 2025 08:21:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Cc: <david.hunt@intel.com>, <anatoly.burakov@intel.com>,
 <jerinj@marvell.com>, <radu.nicolau@intel.com>, <gakhil@marvell.com>,
 <cristian.dumitrescu@intel.com>, <Ferruh.Yigit@amd.com>,
 <konstantin.ananyev@huawei.com>, <mb@smartsharesystems.com>,
 <dev@dpdk.org>, <haijie1@huawei.com>, <stable@dpdk.org>, Venkat Kumar Ande
 <VenkatKumar.Ande@amd.com>, Dengdui Huang <huangdengdui@huawei.com>
Subject: Re: [PATCH v2] examples/l3fwd: adjust Tx burst size based on Rx burst
Message-ID: <20250609082154.489681e1@hermes.local>
In-Reply-To: <20250609095827.4174387-1-sivaprasad.tummala@amd.com>
References: <20250212045416.2393001-1-sivaprasad.tummala@amd.com>
 <20250609095827.4174387-1-sivaprasad.tummala@amd.com>
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

On Mon, 9 Jun 2025 09:58:27 +0000
Sivaprasad Tummala <sivaprasad.tummala@amd.com> wrote:

> Previously, the TX burst size was fixed at 256, leading to performance
> degradation in certain scenarios.
> 
> This patch introduces logic to set the TX burst size to match the
> configured RX burst size (--burst option, default 32, max 512)
> for better efficiency.
> 
> Fixes: d5c4897ecfb2 ("examples/l3fwd: add option to set Rx burst size")
> Cc: haijie1@huawei.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
> Tested-by: Venkat Kumar Ande <VenkatKumar.Ande@amd.com>
> Tested-by: Dengdui Huang <huangdengdui@huawei.com>

What driver? Why not fix the driver.
If RX burst is small, there should be no way to get TX burst larger
than that to happen.
