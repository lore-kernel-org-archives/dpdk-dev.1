Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558B1C5CFCF
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 15:53:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF60040285;
	Tue, 11 Aug 2026 17:53:05 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 555BB4027F
 for <dev@dpdk.org>; Tue, 11 Aug 2026 17:53:04 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-ca88130e09aso2337985a12.3
 for <dev@dpdk.org>; Tue, 11 Aug 2026 08:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786463583;
 x=1787068383; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C0hYkSSvR3Bf23O03le7i86NM/mUJIJRNd6Lf7Dnx4E=;
 b=UhWI91czLeSTpVmTL3vh8CR4DNinjyZf5wjjUZ/9/ga3hn14WxRGVPhbBuLdIpl4ph
 IfqGYJnw+LguCH0Vlaod5qyjlK/O0qxn+uHxA0PPxVIUsIGPketpyGld/GPosmG1P9HX
 QrNio29CqwCUJlF2IQTThtyiLoFyYUR9PjUU5ILuGVnJm/OAfK0rk1uwBPuVnqsutnL5
 Lz+nF5H0rhsJBVPZeYpIA74fh/NRZyUQeBFrFnfEisw6CeHVqwsRAFZ7ZXqgov8/maii
 J3V1DrPjfTX15Q8GQ04DVr1SKd+csTNTpt9XBYrh8w4VZLlbkxEdcnz2GtC05Oj1qEOm
 Budw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786463583; x=1787068383;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C0hYkSSvR3Bf23O03le7i86NM/mUJIJRNd6Lf7Dnx4E=;
 b=blIKCyHNUkHJrX+MDB29UEl0JmS8KA46o/Vb6XnDvGDFnMdIy7QXagxKCIl4YdqQkT
 hnjEyrt4v6ckSel/fod/AkieAMOGORSAvYQXO4+o8Rp1O1+rehPC2mOkkjS0F1y+TSER
 KDhyXhSwBffSiXSl7s5/Fidlepofrg/iY10wki975k8PKCBzE9JpwgInPryo2PO5UwVR
 9Kk+jL6m+hFFZY/lMlIkcYG6bvH/D/fw3LI21agolCbh3dfOQIHe0DbH5ErsrwSMckCN
 Kye33kmks+0t8poE2BYQ6ptismPBH7JMiuhZreAOGtGgZr0UF2Gc7DE1C8x7xMNO1++I
 X+LQ==
X-Gm-Message-State: AOJu0YyIutG+YNXEvTllkHRRY4SxJ6b3UaJG3WizIUdXpa0pkZykvQpK
 0k2t8U0JfguTTYyM1fBiiVM0ReJ/Z5G86LB7BayLx77iByCcccJgWZjkLUKgpyyr+mk=
X-Gm-Gg: AR+sD12RVRKi3CExV5jZMkdcIRQD3htIFhjYBkoV4lu9aSm1lWlB8stYeMmgoNGL1SG
 J+8GPOv8B+9ZFWl4iysth7BGrs2ZIsQihsy4QnUFdU+1IRkZ3W98ICAOosy2Zu8f8oxsK+9wHvc
 kkTGEwBZGzVAIFtwrFr3x6+YwNs/2U9Vgmgapjg7fPBAoZ9NuxiW/+3w8z2eY9rikDLDxAhH8nL
 ctFR+RgWQTwQMkZ6KYMLfMltrHEJ6NDL/HA5S7EBbPd1gyHlzCS/kB85a4d7FhAJP7C2lBx9L4v
 1/HfqtQwWBj2Gehp4v3xiMP4ydHUeC5bfrTBLmQb2VgQW0azMORLpXQBbcw6KLt2D1v/Wx3z6GW
 So67Cr34ldzOPiF2uEJ+XtpEqKxayq+uzLes8yLo0KqMntfz2nCCSCArquMIr502xbWaqyDpZOv
 QptGqMddBlRu4EC5JYjeQpD531iEB8MKMUeGlYhApBfJkykRBGmJVQQCUtE+vtk3ARnRDOXYWRK
 DNsPAhpAZPd4OP/FvncoFQJqBndmQ==
X-Received: by 2002:a05:6a20:7289:b0:3c0:b3f7:e5c9 with SMTP id
 adf61e73a8af0-3cc37e9d2f5mr1058991637.36.1786463583079; 
 Tue, 11 Aug 2026 08:53:03 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31cf678ca12sm666985eec.20.2026.08.11.08.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 08:53:02 -0700 (PDT)
Date: Tue, 11 Aug 2026 08:53:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Radu Nicolau <radu.nicolau@intel.com>
Cc: dev@dpdk.org, Kai Ji <kai.ji@intel.com>, Pablo de Lara
 <pablo.de.lara.guarch@intel.com>
Subject: Re: [PATCH] crypto/ipsec_mb: require minimum version 2.0 for IPsec MB
Message-ID: <20260811085300.66c89502@phoenix.local>
In-Reply-To: <20260811112636.4106950-1-radu.nicolau@intel.com>
References: <20260811112636.4106950-1-radu.nicolau@intel.com>
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

On Tue, 11 Aug 2026 11:26:35 +0000
Radu Nicolau <radu.nicolau@intel.com> wrote:

> Increase the minimum required IPsec MB library version to 2.0
> As a consequence, clean up the aesni_mb PMD code.
> 
> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
> ---

What happens if user has out of date library?
Is it detected at build config time with reasonable warning?
What was release date?
Debian changelog says 2.0 was introduced in 18 Sep 2024
and is Debian stable (trixie).
