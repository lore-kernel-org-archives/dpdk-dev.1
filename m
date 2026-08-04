Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A655AC55822
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 15:52:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3C1D40696;
	Tue,  4 Aug 2026 17:52:16 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id E485B4068A
 for <dev@dpdk.org>; Tue,  4 Aug 2026 17:52:14 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2cc7ef7ec27so29595ad.1
 for <dev@dpdk.org>; Tue, 04 Aug 2026 08:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785858734;
 x=1786463534; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HOqIT5iq4WdthbmbKGbPf4WkRYbBb0dl2nrLjonHtYM=;
 b=fKRodlfRlp1dUkDG4t6iQXKewTn2Hx1FUdRqwsaMiNlyV3aOgDpXJL7l56VYQLnylu
 LL7HUfMAyBdrejFHJ6lIYHWaRHBgDXLh6FlWX+BzzVb6htwYxQAiEQjBQTF/+/BNqyBI
 +6EFDi/UlNerBbzteFFM7c9xQThMxsm4AI8ecW18ecE0djUOt6vhY75tlS41+ogFfZGS
 0VKeQFX//Ht6o2b2VM1VNl5jpfduoSrSez3xq/l39NsDEoQawqlq4ZTOsr+aLOjhq3IM
 0KkY/lIPcPeGD/rlYozOP5Q22MLDiW7SgcHGj/iwKh7wcJIawXQVhENJMI7fZnDxpE0+
 NnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785858734; x=1786463534;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HOqIT5iq4WdthbmbKGbPf4WkRYbBb0dl2nrLjonHtYM=;
 b=ds0bhxGSMJl89OjsWKzIvGG8IV6sHbVa6MTCDmSRrOdPWHBn8gzyy2gY2+VN6D57aL
 MFw59waSiH2jMc3bUmcJGFpx/vQduX8EYJ+KFXQW0SDlQEPIcgQ2KPcNEz3e1jQt39Fy
 PaTFipPzFsHENKqcIyoHr7aXgW9D3LcjDoOz3+xDLit/j1ucH6xz48994y8aqMzvmJct
 H3uBlbhiqbZYqnpF7H/IrAC1mWF7jwQFz+MGT+SHEOw5m2NPwxOgD8ZrseV//60+O3S5
 yjkGLWECtz9KnHNzeN10aJzB1R8D5VVTgW1Kuw/pwTOPrsAR+TUFbQ/AX7VsnaSxWOP6
 r7yg==
X-Gm-Message-State: AOJu0YyBcm1mzS9JCpCfrrhWtXJJSwZ7ijexWP7nITs8fUMlzIXk34td
 px36MC02rPWv0FZlibCc//A9zjDhiXddq0HVoqpmSA2Cw8XjijjeUA4kHkb2AdXRgHY=
X-Gm-Gg: AR+sD10/4ouIg75ndiJMcCcoBUmu1a4/eCKyeMClV/6Ue0mx5IUqqZAowoAvIbZm2ya
 Df03xvgpW+Dd+x12IK4Mhd1EZDxr/qmsu+cEbqEP6oosXXkfXTqom0vCie9B6M6O/kwvdPIcg05
 BSvlQF6aXbON/9TfI2JtRHLfP2+l60LKOjrdEYKV4KWl0AMhsxoWEebN4F5pctQKMzOEW/i1x7y
 +u8l4F943wtbz6WfepQigFOAk520Gfq9jABQH6Gl78E4eU9wJJhh7/nB9XlLQ9qDNrU7WGF0+Wc
 BDhtsZrRUdOCZU3xZKUAxy4Fbps1DbK+MBCMh4pmlJi1tm+BX++IY/sLZM+wI+sCncvcQiFwXjN
 CmGsSnbSXCqTY1V9bnh7RZl/LAU9SbswLI/rDOQzuoT2eYcCTGqKc1EXHwky8ArSkQl8H7sFZcJ
 M0gAvLJFSKYcszJ0Gp+znyeSvojWQv+TDZ/0ECuIu6B4uvCLDTw5A0GohEF3wI/b5ShMpaID9x0
 /yaF5JHbrhSFFGSrZp5OroMXnXv+dSUuNSlbPEk262/vFtvdv5V
X-Received: by 2002:a17:902:e843:b0:2c9:cf5d:d9b8 with SMTP id
 d9443c01a7336-2d0523bea8emr148726475ad.33.1785858733949; 
 Tue, 04 Aug 2026 08:52:13 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315867bc261sm5939476eec.28.2026.08.04.08.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 08:52:13 -0700 (PDT)
Date: Tue, 4 Aug 2026 08:52:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH] eal/x86: optimize memcpy of small 64-byte blocks
Message-ID: <20260804085210.74763eb5@phoenix.local>
In-Reply-To: <20260804143305.1344327-1-mb@smartsharesystems.com>
References: <20260804143305.1344327-1-mb@smartsharesystems.com>
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

On Tue,  4 Aug 2026 14:33:04 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> +	/* Common way for small copy size of 64-byte blocks. Unlikely, so const=
ant size only */
> +	if (__rte_constant(n) && (n & 63) =3D=3D 0 && n <=3D RTE_MEMCPY_BLOCK_6=
4_MAX) {
> +		void *ret =3D dst;
> +

Maybe just let compiler decide, it will generate vector instructions in mos=
t cases.

	if (__rte_constant(n))
		return mempcpy(dst, src, n);
