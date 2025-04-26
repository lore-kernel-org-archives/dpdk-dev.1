Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC8EC369D1
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Apr 2025 16:16:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78B6E40664;
	Sat, 26 Apr 2025 18:16:03 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id B462C40647
 for <dev@dpdk.org>; Sat, 26 Apr 2025 18:16:01 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso4556813b3a.2
 for <dev@dpdk.org>; Sat, 26 Apr 2025 09:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745684161;
 x=1746288961; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+YbsqKUbFviNlk499FoFoJQ1F21D2A/CuakuqhsmO2I=;
 b=a99UZ0qtn2cUMFSnImFDARE/5IC4ChTiA5jnWTxwDpwlCr+x53SiATRNGmoyg4KVBm
 jm0/YLzh+tbrCsFyV1RGpljUIGeNIOgqRUDYXg+TjPKBWRLj4335uuhS0466xvYeDTjq
 UwK4kMRFQiqXsCTGX/2bVXnZTwk9q2GtEFfr+X1irw9pGUlbFiyYDaskDq5tRaCq246O
 xy/uCcVEegZ0rHw/5aEpZwLX0fMzyNapmK9cxFgUY2R5quZ5ugNDrP5fz7mRjEfL1nho
 UatPbMAhhso3AioHQzzjK+n7wKmsTkwACctPz5Q04JFtBGk7CFTez7Y2Hj7M7m5+im5W
 ojIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745684161; x=1746288961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+YbsqKUbFviNlk499FoFoJQ1F21D2A/CuakuqhsmO2I=;
 b=K0Ao6YIQ4c+wvj1IWeqiUBn4Q0WfQ3YYZdcKQNEGMEFgozV4TaaFetu+p7QyTTO2GG
 YzgZQdLP6wX6IEWtgln1sOsUJjAZ3KsXw8Wdb/pUSVehRGuSgjvf/wM2ak31cgYmX//E
 eGC9T6SMLBSt9KpKp9r80kTQkgI1ANTRElZdDxfdh2sCdmCwmuFfvLpszgQ5OBZqaDEx
 7K+Msd5rOtUcgu6+XD3RdSoixoXY0ICfh0KLqeZyZ7of764JFbtMmK6B5ffbDh+emXz8
 5cE5y8YYzAAOmW/jn/NPdAKcSHuHUsp4p5EtPLMlEC7c8gIk2xOwDOBMpIsbvMAPf0cA
 4VNQ==
X-Gm-Message-State: AOJu0YwZkaCOCH8BS7X+DoIn72gna225g2dGu8ViYIP6pCxEJv1pyPHY
 YFY/HEKO0Rfz76v9phd1zuy66JNBKCDUbgP1kSEBoB5trzbs0EAh5jimRea7LT4=
X-Gm-Gg: ASbGncuwHPU1SElevTcULyZhAwiNtlqIj8rJ8Q8F0hAMiCfZ417ZfX+FeGB9FgFrtqa
 l2iXUnuRxdGiYnnRV1JoRQUNXAVKbLzQZbrI376lik2fwUOK9D0rbjrrvkqutfLY726XVRwQ28d
 3+bWqdQ1Avk3uDMIHkxSfYq3bRLcJOwcs4BfhgyZ2q+v/223GFQKbfTGx0V5roMxvdGPtH8zicM
 IzCq5IlPs9XPYvoFPWGJKiq9IbxmjNsqa6ILWM+B3XdQhHH/LV5iVR3T3TruwxwCS09IOAZR110
 IfoowYgut+KqFtd775KAVqwPzRhh1XLKuUyd0azA/Uf5mUXTCNRMBuLzjAiKXwWxtwqQIWb89bw
 FQLCCJFrW1X7ZHhOf
X-Google-Smtp-Source: AGHT+IGlQKo3nCNk8QvWh5P28Sv1/F+xN3xOzhrM8UexRD56ltLlb1sJG7bKQAyUviuzwf8nWyXIxw==
X-Received: by 2002:a05:6a00:148c:b0:73e:30dc:bb9b with SMTP id
 d2e1a72fcca58-73fd69f8c6fmr7758057b3a.2.1745684160895; 
 Sat, 26 Apr 2025 09:16:00 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912a93sm5174743b3a.16.2025.04.26.09.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Apr 2025 09:16:00 -0700 (PDT)
Date: Sat, 26 Apr 2025 09:11:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 02/13] net/sxe: add ethdev probe and remove
Message-ID: <20250426091101.124f84bf@hermes.local>
In-Reply-To: <20250425023652.37368-2-liujie5@linkdatatechnology.com>
References: <20250425023652.37368-1-liujie5@linkdatatechnology.com>
 <20250425023652.37368-2-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Thu, 24 Apr 2025 19:36:41 -0700
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> From: JieLiu <liujie5@linkdatatechnology.com>
>=20
> Add basic modules: logs=E3=80=81 hardware communication=E3=80=81common co=
mponents
> and support basic PCIe ethdev probe and remove.
>=20
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
> ---

This and other patches are getting reports of sign off mismatch.


WARNING:FROM_SIGN_OFF_MISMATCH: From:/Signed-off-by: email name mismatch: '=
From: JieLiu <liujie5@linkdatatechnology.com>' !=3D 'Signed-off-by: Jie Liu=
 <liujie5@linkdatatechnology.com>'
