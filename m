Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF92D1268A
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 23:56:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E2DB4021F;
	Wed,  3 Dec 2025 00:56:58 +0100 (CET)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by mails.dpdk.org (Postfix) with ESMTP id 48115400D5
 for <dev@dpdk.org>; Wed,  3 Dec 2025 00:56:57 +0100 (CET)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-4ee4c64190cso46702191cf.0
 for <dev@dpdk.org>; Tue, 02 Dec 2025 15:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764719816;
 x=1765324616; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tsuIvbZe/STVWs+4adRlw7qOExLmXdCYxaw6Co4VR8I=;
 b=Pdt9MnMZSSMOmzftWd1suDIPqjosHlYTPlSrg9wK+CfP7yR8viMIyQcETD9fjtEN6U
 UQoA+S/4rn602cSxp8mbcQCueAJuo+Goj/TI6HFVr2e3s5DezXsxqMFgUJ8HCiqAQ9GR
 VlfqHtpAWrMiqnXIEcinqC/WmDcf9xPF3QgnQVOuV+MFFvk+DJjTU6P57nB1IzfEbzgu
 3xYe+R1AOALhjFXyLE5I4vJ8wSm+R7duDddX+Y04HBnvDWs/7tmzvuERMCTnNI6w88x5
 KJxxraCx0jw+wDVtq11WUaF1IWz6o+NGBD04/bSS91T+n7i0pBDYWsO/cECLN8Akd6ZT
 7hSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764719816; x=1765324616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tsuIvbZe/STVWs+4adRlw7qOExLmXdCYxaw6Co4VR8I=;
 b=H5UAK5fo0ntDce1Hvo1cax0woKM8CACeiHGf4GWPAdfj/Bq8aCwgXMHGY6uqtVydi9
 S1fT/hOYFa5trEe86nFYo3LLIES85sPlvTvxdsSBLUTLq/RiMw8Nd6zQL2v7wVEi7yAZ
 a8axhoXQWZaQ4gNs4Kj3vxN4+b/6qEqTpzf7aJxSB6wziyo5MUl1hc71WJ/43zn0t6gV
 r9lsajrDSPMGPSPpdq+lFbVZUkAhzEDuGSf79YJA/rE0h3KdHDkM/Xkn1XsYhwEM576c
 CvHfLnfycTj8+aaxMGcZ6bznk7z2nyTZvSSRFGY1hiNOLP+9ji7gDZe2I33ERlWZx/zf
 qv8A==
X-Gm-Message-State: AOJu0YxAliVZbtofdiycPjPALK9wf2mCEm3fWa/FOMGgDbtLQelipM7Y
 Av6ct6tH2Y0cL/V8e6ugjeZx+9RNA7yMn7Daxj+79/oNuP705rrXOFPKGeZkaHTSQNU=
X-Gm-Gg: ASbGncu0mHaik0B7aUxAcONlHbaSVeXhq8MQWcF8zc88zm0LhBsAXXd1eonqtNTbLld
 GgqPpZtb4C/eUACi/a+VQahbsd7j7LyEZDQ/ycFBRSBdKH+Tgl1gFy/k7Xauq7jw/kaPtpE/FPs
 uWlIujtzG7aHtKlPacgdors1oq0W9o+kNgpiW7MGMAa769o8ZCb+FRrXC0NkngcdD5NoljA9vlM
 JFbtjSlnY1nVwug0BmQz7qH+aNAOrWF5/23KvlCUi/8MubRZXIbypVpABdcvyuutw0SYTrDJT7c
 djFppldqsLKsqFZxPUKQhFR5PcnVspMcp+UNh2PwPLQxdEmUACN5Tot9KRp+2/JdhxOv2KO03qL
 piCragF6+CxD7cv8YRwVoDz6q05djTl9cn1LeeYZraRNuchA4gINBAuOID5p1Sx/6jponNTL2CK
 YkZoR+U29W6Mwg7QCbPG6Vfe2Z1LBl+tir1I1lQpmRPoH359TJuAvC
X-Google-Smtp-Source: AGHT+IFOmWw+l+g5ftwtc3PZ1ncR4GavsxVK0DzRzOKdBfURXldQFBrCEofFTf/N2FW7URh29NIB6Q==
X-Received: by 2002:a05:622a:50a:b0:4ee:60a6:ee03 with SMTP id
 d75a77b69052e-4f017683bb7mr5105981cf.41.1764719816471; 
 Tue, 02 Dec 2025 15:56:56 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88652b494e0sm114507896d6.26.2025.12.02.15.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 15:56:56 -0800 (PST)
Date: Tue, 2 Dec 2025 15:56:53 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vinay Govindaiah <vigovind@amd.com>
Cc: <dev@dpdk.org>, <selwin.sebastian@amd.com>
Subject: Re: [PATCH] net/axgbe: add support for V4000 Kracken2e
Message-ID: <20251202155653.05f83806@phoenix.local>
In-Reply-To: <20251202071152.317942-1-vigovind@amd.com>
References: <20251202071152.317942-1-vigovind@amd.com>
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

On Tue, 2 Dec 2025 12:41:52 +0530
Vinay Govindaiah <vigovind@amd.com> wrote:

> add device ID's for Kracken2e to enable
> driver to support this device.
> 
> Signed-off-by: Vinay Govindaiah <vigovind@amd.com>
> ---

Applied to next-net after fixing the incorrect indentation
in the switch statement.
