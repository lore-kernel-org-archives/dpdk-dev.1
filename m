Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E89CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 05:07:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C803340264;
	Mon,  1 Jun 2026 07:07:29 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 7CD5F4025F
 for <dev@dpdk.org>; Mon,  1 Jun 2026 07:07:28 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-304f590dd91so2099808eec.0
 for <dev@dpdk.org>; Sun, 31 May 2026 22:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780290447;
 x=1780895247; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zRcI1Dui0MijN9claFYcFaBMjjoTGM+z4r8M/A4Uwhg=;
 b=ARYFkHO6Jmigq1ZMWR/PyT0OkRg0DodlmjNe3/lUMJr/pvyNO2AYV/Wbx4OU8fDfKg
 2IzjzyuixghPy+YC9LP8ANtBuKA8TUg/MzN+zRdGZYYk+HcYRG5drCCi/nHuYzld8F5F
 pcPw0JD9xnYcA6D6NbTOPoqfy35MuABifHZLKl0aqWTZiI7cVTlbA3zOigjZgFJ7Ql/S
 a3PXXqOgNGDpRDjG6L0FVZYL/sg3zPoNB4MzoVeWxNcrNso0v2B+o5beQXOClugBvuyq
 Z+5crqggQJFp+6PxrUeMDIOTgRl5+yavK2Xml6X+4eHIcLmY5JKrFUD8P5ukzwk9tmD1
 wF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780290447; x=1780895247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zRcI1Dui0MijN9claFYcFaBMjjoTGM+z4r8M/A4Uwhg=;
 b=sksZSDGLFeR3rFcqDdbcWhqy5f0rvVQ2W9NVKhAgi4yJiIzqozfrRTYSa2VNP9Lixt
 rDScVDtOhYu7MaF66HWkRmHPHRfhVUDuL+5EvkRFKogfnMXrDBsUSXG/EHMddfoLwVoh
 PpWW++g6EQeB9+LY7wD29a+SfVHCvEIU7OUWmy3DFJJM9CyICpeNoFVV2wNcnSUMgnrb
 JlCsvY+u0C3ZNLyArm2UlFf3u6GCvawrcS2W0qspYPf5WvzjLNHlLS3X2UIxVXcKKfGD
 r+wieIYPzG3z8sLPzZKoaLkgOVCkVDukdKT+3vGcdYEg+uGAgN2dLELNyVXGBBO8Oetx
 Kpjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9CnblqG2i5chP39BynYZaDalhhrksPGm6ae0w4dsV+Ctvs5AAcPDyppguSN5z71z7i9vw=@dpdk.org
X-Gm-Message-State: AOJu0YwfT3GwqIeUkpFTQ1UWM979X47PUI81pXvWQv0nNr1b7xTfQk2H
 vwPXege/1lgvTHeOJ18awyzozIqudshQr83tZXD3RWLc51hQNOiPwKNXS7F9jphdkvg=
X-Gm-Gg: Acq92OH9XyaimSKVQGRu9lQeM8gJ3SSRi+azM5FSouu2rc41BNAk3TE38GxDFc6pUSc
 +VlHX8PIAl9+P/OF9XQnd1uapsPeEjmCb057ErEvvLoIKAZ4EWjgH6wytCM/kZpOe8s0UkUuVCg
 jb4pnWMMi2mQFZm3zbf2kAGJNm632i4+EVKCqDfXQfyuRqlypCxr1KP+aeo4lRYZtkY702HQzMy
 5l12amZv/O7948LkB0XDv9LjeH+Bc3M5Sjde+UDNeczl/5nuyPsXnNlsElmW+ScOYJ80PiLr+uH
 a9OIiWb/YAldI8LjTy6+nJUW6+bfWHtjvWTzqlnhAXZGOhSIBkE6yLo9/Mo1azSbWirORZqW3ZF
 JBwdcL18ZNG3+VGoLBczTGFi8mysgs94UQWu5N+iDiYhx1sPP/TPPj45WRUErF15MA3xZ1ksEeI
 kBpnwtGB+UtQifHqVy6XogvLqemVX4u4ip/NS/5VXwWDY6QE+gtb0ceC9xRstXlRPWUCJe9BPO+
 sg=
X-Received: by 2002:a05:7300:e12a:b0:2d2:96e8:1bf5 with SMTP id
 5a478bee46e88-304fa526456mr3363418eec.3.1780290447337; 
 Sun, 31 May 2026 22:07:27 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a0b7dsm8288746eec.22.2026.05.31.22.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 22:07:27 -0700 (PDT)
Date: Sun, 31 May 2026 22:07:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Ajmera, Megha" <megha.ajmera@intel.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "Dumitrescu, Cristian"
 <cristian.dumitrescu@intel.com>, "Shetty, Praveen"
 <praveen.shetty@intel.com>, "Singh, Aman Deep" <aman.deep.singh@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v2] app/test-pmd: add generic PROG action parser support
Message-ID: <20260531220724.0070314c@phoenix.local>
In-Reply-To: <MW4PR11MB589273F3A331E94D0876900D97152@MW4PR11MB5892.namprd11.prod.outlook.com>
References: <20260521055612.508916-1-megha.ajmera@intel.com>
 <20260521101354.726240-1-megha.ajmera@intel.com>
 <20260526122218.1c29d917@phoenix.local>
 <MW4PR11MB5892D90B2AF860214FB57F4D97082@MW4PR11MB5892.namprd11.prod.outlook.com>
 <03ab65f8b69a4018aad7afcc88f337e1@huawei.com>
 <MW4PR11MB589273F3A331E94D0876900D97152@MW4PR11MB5892.namprd11.prod.outlook.com>
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

On Mon, 1 Jun 2026 04:33:42 +0000
"Ajmera, Megha" <megha.ajmera@intel.com> wrote:

> > 
> > For my own curiosity: how user can define his own PROG action?
> > Is it supposed to be programmed and uplodaded to the NIC by some external tool
> > (P4 compiler)?
> > Or does it refer to the set of some predefined functions that given firmware
> > supports?
> > Or ... ?
> > Sorry for probably naive questions, but I found is nearly zero information inside
> > DPDK docs about how PROG action supposed to work.  
> 
> PROG in rte_flow is currently a vendor-defined action interface (name + arguments), not a generic DPDK programming model by itself.

Supporting vendor specific extensions like this should be actively discouraged.
There is a reason DPDK succeeded and OpenDataplane did not.
