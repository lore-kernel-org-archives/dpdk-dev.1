Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F591ECD9AF
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 22:11:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C21B4021F;
	Thu,  5 Feb 2026 23:11:38 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 4AB194021E
 for <dev@dpdk.org>; Thu,  5 Feb 2026 23:11:37 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so15462155e9.2
 for <dev@dpdk.org>; Thu, 05 Feb 2026 14:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770329497;
 x=1770934297; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSb7YLOqL15wJasbPteTMq+q7CsfbngNt5kyqd6bSgI=;
 b=QO/k0W2gmhyjGPJmC7taJRXYT35zV1TQWLGAeBaj0GYu+O3Onx3uA2+euu49ebP0/a
 W/me06X33FBYeP9K98s2FWZtj5H4WQf6MwlP1RQoDw/Z0L23Yv68T5/r8AdqwlWd6oh+
 Y+M6RoGAhY8oFew1xj34PCcFED2OH1oPgBJA7rhfVymcJYFZ1NvseXZNi01eGE5nb1gs
 wsm1Mn5lIPCgRsuZ3bCwZP8C8SYro2xqO5jdGSdR0gTRSBZEISsBnmC/W75Hnodno8C7
 gNrWpZNH0F3pIBbYWS1j9c3eiCZ6aUTihI7wtiMgwlXqsIKW6v0m+F60XKJe2Wt5pMT6
 7Hzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770329497; x=1770934297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mSb7YLOqL15wJasbPteTMq+q7CsfbngNt5kyqd6bSgI=;
 b=bAQBq7ju8+1EOqef1BlZnDlK07kCd+o0vLSIYINXsX+JwUViX2lZvYMbhimNyf/+XH
 vSLSTr2brvXP/ZXEgIWOE4JV2GO3Z8eFyJNdcetfBfVCpYA6MUgXnSDGSmc+d5cO2BNR
 t6zXpZMShoEqfEp7nasen+h4ec7rvmme8f97gv5/pyxpHufDzsOPzffFk9ad8wCVHfFV
 SUfKH04DCu1loJBIuJn2smPGGyKcSkRzsP91H5067jmfEHAPAZHZvD+HdW0Oi2ZGXJvQ
 2W1rC0XjkyjBpfr6unDWLC5akaRznuQr4h6mym/te29KQ3D/+gw2oZ9Ex6oCFV9+AS96
 bFSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo/Z56dLQqJ8FqE7Pl8d4Ym7sn8mr4syhDNCh92DiYCBLq+MzSq4mmvDJ/vD5ho+q1cec=@dpdk.org
X-Gm-Message-State: AOJu0Yw5Qlu+v6XRy3/VZ/q5jxr8Wv5B7etLHe83X8NgjP1EthxUKCUk
 2SwKO5HdrCn2ZxTHtwsrPzTP6+anztac+hN+0IQEv9GDb5IYIvP/Jcl87BID3NTaJFcyADvb0+G
 DIPCj
X-Gm-Gg: AZuq6aKVq2+fQ8/SxFUB/eO/mhvSnscuuCST+YgTolHKbwNwfB9b4UYDXKvvS/hVa4P
 rMwI2B/q9DrBImmBd1Ns9PiI00gsz+qb2X69+L3tKuR9DpzwmQtpMGkLGf6hb/Cq057E4IguGvt
 6fCXACSGZLi3zeWj0q6IrWMawxbbnVzSC1uO9D89IlQBdpi7gdKwiGubQkPJYGzus3dunqIwYGC
 D29sM9Jn9JzzVs/iL6f/p0r+WmIFba6F4F/7z4GWBhTkQ0aDvLrocleFcXEQAG6dIbW0WEWB5FH
 Y3oizMqSPj4OJf6QJLxFW4QKtG3iJerjvBoY5R6NATahR/Jh5kngAfrOw9tM4SAW5aQ3/zYydR1
 pFC9yunrdS+jACyxkPmZPoF2Vp7Ht3tudqoP+efsL1Uy8ma/qtDGV8wLMeG2Dy40OysZ5l7kv4R
 rwLz1QfBmVUw4Tl1AVwCs1ney1uq2kUcxDM3qV4zwwd+MjBEbP/lIg
X-Received: by 2002:a05:600c:6289:b0:47d:18b0:bb9a with SMTP id
 5b1f17b1804b1-483203393b7mr12827805e9.33.1770329496669; 
 Thu, 05 Feb 2026 14:11:36 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483206cc7d3sm8490885e9.5.2026.02.05.14.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 14:11:36 -0800 (PST)
Date: Thu, 5 Feb 2026 14:11:30 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tianhao Zhang <zhang.tianhao2@zte.com.cn>
Cc: wang.junlong1@zte.com.cn, yang.yonggang@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v3 0/2] net/zxdh: fix npsdk bug
Message-ID: <20260205141130.6431af14@phoenix.local>
In-Reply-To: <20260203071732.2601630-1-zhang.tianhao2@zte.com.cn>
References: <20251230081127.813605-2-zhang.tianhao2@zte.com.cn>
 <20260203071732.2601630-1-zhang.tianhao2@zte.com.cn>
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

On Tue,  3 Feb 2026 15:17:27 +0800
Tianhao Zhang <zhang.tianhao2@zte.com.cn> wrote:

> V3:
>   - Fix the indentation issues=E3=80=82
>=20
> V2:
>   - Resolve code style.
>   - Provide clear error messages.
>=20
> V1:
>   - Add new timeout error return.
>   - Add PCIe link health check.
>   - Remove the NP software resource uninstallation procedure from the NP =
online uninit process.=20
>   - NP software resource uninstallation should be called separately withi=
n NP uninit to avoid duplicate resource release.

Queued to next-net, with reworded commit message
