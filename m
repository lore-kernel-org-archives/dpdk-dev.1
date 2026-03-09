Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C536EEA8542
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 01:29:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C20840281;
	Mon,  9 Mar 2026 02:29:33 +0100 (CET)
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by mails.dpdk.org (Postfix) with ESMTP id DFB8E40261
 for <dev@dpdk.org>; Mon,  9 Mar 2026 02:29:32 +0100 (CET)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1271195d2a7so5677913c88.0
 for <dev@dpdk.org>; Sun, 08 Mar 2026 18:29:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773019772; cv=none;
 d=google.com; s=arc-20240605;
 b=ClXj7fL0E41B1ahasUNrklckDQJHfgOLcdsGdMwaWtl81X5hcYRv/OltOAN8I3WHM5
 T2wNhI5Ad9NGGpuzLPMAo6PF/jIBt2l1NSHclrRG/J1+Ox+TYkgtUcfGSnckcrjNFiR9
 yyVgLXHqT9lMRlcIo8KHff7DqMeGVxGLhqUmBxvUtPU0Ax4fkWvsJTfyxzMd9sl0YhSr
 QjocuvgLyd6p3h1wrPjub380dt7MRjH4gTGyqgdD+42VPFgbAsHPgousmTU2bc9xda4x
 59Se9KOhuKtxNLyKPHizz6BxuJGoQoVR/IOmhum1QRFHAxnYN9ezrA4+k5mOiwX2HCKp
 d+Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FBgeqUCT8MY0UnbhQUCUQ6YLX7/FGRdFb8sLyh4SXRI=;
 fh=dT+q42HCVdfKIpPzm5+1/vbsdngq/c9ylHuTOxGWLWY=;
 b=FBpv9+iluzzBsx+LDyHyDZi+kSmH7wTPo6t5fmI1M4eGXnTEEjnBYNTL5pniec7uIM
 FlLZmg86xkR8Oizyw2Xxm/kBXNhDDZmm+19EiEzUUlRE8nyfTmWf654BIhdu0YYT11uG
 vXxwIm2mxIDTOOyINGFviUdIlgiUXonAxd5lnVPSed4+IbbSvCKWRFoF3zZgFk70qmWc
 xbOetcrrvDWQ631bYamcfEdp+cd/XJDtAc2bBXJ0t5fTXV4c6VR7vpgTvYKhQwu7pQiM
 2BvUN8ivnu6sdPsSbeiCPuQPvB+FKnHosmM3dCsexyqw29a48SigZjzLdXVF46jfnncB
 PWyg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773019772; x=1773624572; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FBgeqUCT8MY0UnbhQUCUQ6YLX7/FGRdFb8sLyh4SXRI=;
 b=Iy+4CyEKV2CwKpXsExsiEQscIDL4Wo2wSNKL/60rsK5JB4L6FQzsUvR7GMMl2wDQj6
 AArviw4RB6IRZI0qYwyF/2HgDgrVs6Ktx+LAF6ZPF20Td8pSMmFfMv1625nFIOuI7LgP
 2RPWP65cvhevIMRm0wLpcp+sze//9S8q/KzCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773019772; x=1773624572;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FBgeqUCT8MY0UnbhQUCUQ6YLX7/FGRdFb8sLyh4SXRI=;
 b=I2IHtDzjEy7DDxl3i07dADf8TLtEcvV54urkQIZrZ2lTHx6VDssJBX+NCafIp8iBqR
 dCOuTMAV5LBYaIUNEfq8Z3mL+w8hXx5pgUUTMqoCq9P2YOsT7n5DFemCKSe3oZeeAisd
 WlkAVzYYazoZzJhcM9KM1x+TmNzgE8QqPyU8oD6NHN9oQFuBWnxFQUZkEoZqnlxpZYkh
 ieuw01Zq72XaRtfBWP49Z9c9hk1/vX9Zg1zIIrTzAnTZwPZIqwxnAC+L6yEQ3g6/z39g
 dOPEDbzXJPA4op8xEelc8TK3R4zS/9R49EL/zQtwJVSSGDcQL5yFbdcTQwApmwqy2BFj
 Rl4A==
X-Gm-Message-State: AOJu0YxUV6IreI1xQLXpnYJaRFmJIaL66rbZbxu0d3Si2MCWf1tcp+L3
 CShTxs8XhjaBei/7Itgmpw5j32vFN6cYDd3QnujQZZpbaDmb6SljI49Xk1SOIEfddBkBby75GHz
 pKHP+Ck5TZ0l1WDRRZmMZQgLzmpubFYyhMrhinFdqlw==
X-Gm-Gg: ATEYQzw6ybdw3ceoeE4fG/1Ziwy4gFfpSbjaYFR/xPia7qYi3wKp5ncDsfys/+Y7LGA
 04LG+corr60EbmFdajYDIJQ+Oiew3ZPlD7FsJOdftGLVbBb1cG9XqOfMHr5oaHqq04DioGo2Y71
 UmcrnySmYoBCt50XXiOI/D0pmqMbgBeVjD3Otdd+iCRMbMgtSX+Im2Gsbi6X7YtuC09P0zTO7JC
 Djc7pEQln+uj34XwO/RwpQmRxq8FMB4mnqFvDMiN3eyIKWsp06Y0MuUfgsPYKOHzv9QDhIkZiv9
 3wXJvzinyxlQipebJ2g/un//2zqBffbNMO1hB4/SvZYfjt3x+XqbHvY=
X-Received: by 2002:a05:7022:6609:b0:128:d7a7:5261 with SMTP id
 a92af1059eb24-128d7a756eemr609750c88.30.1773019771856; Sun, 08 Mar 2026
 18:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <20260306164027.171723-1-abailey@iol.unh.edu>
 <20260306164027.171723-4-abailey@iol.unh.edu>
In-Reply-To: <20260306164027.171723-4-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Sun, 8 Mar 2026 21:26:30 -0400
X-Gm-Features: AaiRm5230-B5GqjUp0MQVxsHSQvBdO1Fv01fBEtIJZwDLTV9GPVHB8qzH1dEJdU
Message-ID: <CAJvnSUDYjtqhO3E3VU82VP26saOnhNdtjC_vwR2G+O1OMjKNAQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] dts: add cryptodev package to DTS
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, luca.vizzarro@arm.com, dmarx@iol.unh.edu, kai.ji@intel.com, 
 dharmikjayesh.thakkar@arm.com, david.marchand@redhat.com,
 gakhil@marvell.com
Content-Type: text/plain; charset="UTF-8"
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

>  # Optional Fields:
>  #   `hugepages_2mb`: if removed, will use system hugepage configuration
> +#   `cryptodevs`:
> +#     Uncomment to run cryptodev tests; add physical cryptodev devices by their BDF
> +#   `crypto_device_type`:
> +#     Uncomment to run cryptodev tests; the device type of the DUT e.g. (crypto_qat, crypto_zuc,
> +#     crypto_aesni_mb) the complete list of device types can be found here
> +#     https://doc.dpdk.org/guides-24.07/cryptodevs/overview.html
>

Applied to next-dts with a git edit adding an additional semi colon to
the crypto_device_type to separate the 2nd and 3rd sentences.
