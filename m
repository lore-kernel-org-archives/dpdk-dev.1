Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F7FCCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 16:28:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC65B4021E;
	Fri, 24 Oct 2025 18:28:29 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id 8CF9D40151
 for <dev@dpdk.org>; Fri, 24 Oct 2025 18:28:28 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-b6cf07258e3so1782477a12.0
 for <dev@dpdk.org>; Fri, 24 Oct 2025 09:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761323308;
 x=1761928108; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5U7sB7hgebaW+ITe1pQp3fYA+TaipqPudaCuIMRDCXA=;
 b=hGRSZOAgrxXYE3qfjEdYEbk73nDdC0sA/p9AwnpWmpGLNH/li+Iy/F3cSakOif933K
 0ZcVtK4oINlmDLY4fK4EsL8cMYUIr5VfrwdmeIeDdEfxBOjFrv3KjfDxZp9nZ45rtz0F
 yVaA4zt+jNfRQqUUs/MjdW6rXcT+xYo8nQqTNueslvklcNTYWRPvgxrTzGy1WGx7nCMD
 B0T1xL/Z2skJudM0m4PUBlAG7PqBLzx7LwoNP4vgbHgycjp0KmknzMTWke3rXlCyg5Bh
 mYtVquQkYcxK3SITnVucC/Z/kMwZDsV6M4Wi+v3p4dKj5+MMu6ZJQtUtBNTTJlzYOPf3
 ChWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761323308; x=1761928108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5U7sB7hgebaW+ITe1pQp3fYA+TaipqPudaCuIMRDCXA=;
 b=uauK0Ddp91diwvI3L17rX1Jmxc55C486BEOg7TWEVgyxSz/8m6uiGsExzSvrb6mhiZ
 CUhykUiOh/gYCBr+W+yvSQA8ZkUR74vEolFZ/iFx0XqUmH8YMNy/AFOd58RxEJTd6O/r
 t40GgSCMP6WlsmjSnc3z14bepFyZ4fJfMzzvuknqJHqjZOOx/RIW9Isj0v38g6y1Z5C+
 xgQYdA/W2nt6sBVElMpQeaUlB+BDDuqHhAyS4r+2vNYPW6ujy91nEkIjt7LOhu3iYTeg
 uOqyKoAr9S3XmoOHx4nrDj+BhwBnLYDLeAOx1voGokyJIVsyOOwRbxev72rnwMVuxRpu
 m8Cg==
X-Gm-Message-State: AOJu0Ywut6acApYeqlQFWk/9agaEMjNbfyrHtU+Ha3A9XRutZCRVE+Yz
 gn9GkziYAq2cGLyjsGVthQdXtuHChcrPxNAkB9PYD3JO0CPGxHN+LZJpCoD+/hI67Cc=
X-Gm-Gg: ASbGnctAgjhEV24mBAMarC9Fo2Kw4rSoQ0m1sIOz+BMDcMeIaGTQt1l5mMBvFbeJAgR
 0QcgFWR6dngwB/mOl4EBCojFu18iDbv1H3Frc0Zzt0DH2sp/kP7S0dJB+6wN1s7FOd0HEK/bRev
 5/VT1PVUGrFR1AlB+76rPdC0TIt6JrAAngXBEZFPHrht2mprEr3T5yixW49w7VrkJs9UWUcNbCS
 HJZfsDVdJiHh/Jqp17eA3ZACb04jHQ9OdjMa7bPEaxlRwvmtps7/WGcRENV1jIdi/GFDjRFY4aa
 v6FdMsnmtMUoin2/H7RUqAbz4OKFADjfneqKW7jERkMyMnTlFV0O7BGmvv306MiYf0K10CHnJcO
 vCnvuD92CedOEvBkeXMFsJhYBcAFL1qX/DSL/8u1C3WIVB+IprvwdJnlSpjL3i8hr3ZXKEDVGA8
 eu4je0XWv9NmATOl7X3t9cGoieNr+EAqW72g==
X-Google-Smtp-Source: AGHT+IG3EbmpbKrKD+kGo7Vd8vvMpS22IQIY8vpg6qBbhF+ijByUD9ppfkFt0HIi10dV6b+okRJTtA==
X-Received: by 2002:a17:902:d60d:b0:270:e595:a440 with SMTP id
 d9443c01a7336-290c9cd4b48mr331462775ad.25.1761323307614; 
 Fri, 24 Oct 2025 09:28:27 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946e242707sm60385235ad.108.2025.10.24.09.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 09:28:27 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:28:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, rajesh3.kumar@intel.com,
 aman.deep.singh@intel.com, manoj.kumar.subbarao@intel.com
Subject: Re: [PATCH v1 4/4] doc: add PTP IDPF documentation
Message-ID: <20251024092825.2180aed4@phoenix>
In-Reply-To: <20251024120840.420016-5-soumyadeep.hore@intel.com>
References: <20251024120840.420016-1-soumyadeep.hore@intel.com>
 <20251024120840.420016-5-soumyadeep.hore@intel.com>
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

On Fri, 24 Oct 2025 17:38:40 +0530
Soumyadeep Hore <soumyadeep.hore@intel.com> wrote:

> +Time Synchronisation
> +~~~~~~~~~~~~~~~~~~~~
> +
> +The system operator can run a PTP (Precision Time Protocol) client application
> +to synchronise the time on the network card in ACC
> +(and optionally the time on the system) to the PTP master.

The term PTP master is deprecated in current standard.
DPDK has worked to remove references to master/slave.
