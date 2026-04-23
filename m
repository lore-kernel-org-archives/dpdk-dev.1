Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128CEFDEE2C
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 17:03:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2D63402B8;
	Thu, 23 Apr 2026 19:03:37 +0200 (CEST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id E7B9540272
 for <dev@dpdk.org>; Thu, 23 Apr 2026 19:03:35 +0200 (CEST)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-8ef5776530bso299679785a.0
 for <dev@dpdk.org>; Thu, 23 Apr 2026 10:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1776963815; x=1777568615; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t73/pdL1dFOujC+aYV8V0uGK6ILzdHFR2n7ZxEa1SDc=;
 b=fJ+boiLvFsddCHBK8h5Jni8NE43AGt9T4RqRt0scMMtnN33g2LQotZ9sAl/KfFqm3h
 mwBW/t+MP1J17rGFyDzKgjBWUMMRECZbYkVZkV1o6Wijf+L8UxHwSHv3k1VTEmNiRofE
 Zfd26c+u+H0enMbhDgZEpcV+LcAJH8LTf2rvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776963815; x=1777568615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t73/pdL1dFOujC+aYV8V0uGK6ILzdHFR2n7ZxEa1SDc=;
 b=hWQadn7rlwBFCNyKRnLSxedI3DAbogVfSWzBu/Jkcf6DhlWBZZxxCPbAymkoJdnkM6
 3lvar2Lv1UbeKvEbti67XoEudilil8FEckgaOJRvCBeZfBjNo03HW40NFtY2s9DkrhYJ
 5uNdKuGS9j0mPjhDAGLxCU3hdgAA6Yu+tujmRtv9Q8It1qo9KJgrXAZ7mVbHMHt3FWFQ
 Nig1dNwxCFLbmTYWaRTkK0RcGbcFOGTerh5+pzhfsMeFWXrXy5iurWOHjmgjV08GM6f8
 QJUpauAIGun0g12TSUnjDWrb9BiUWP75aWMpb/OvGLhY7pQsfB6K0AOMB9dpxmWbTewE
 z6tg==
X-Gm-Message-State: AOJu0YxKljGRKH0g2jmqrUA70Yh7TgBq/pHAziaJZN6yXrzMmlrpUVLh
 ElBvYaLepB5llUxh3SxRZi+dMB6fcT3a3shTc0ktB2YIYFpU/E3Oqz10aRJqmQ4MVxEqNqLWs4h
 lVg6y
X-Gm-Gg: AeBDieu442/Z3uUBkoZOrj1yWJau/EWoO3G1fUbPXoM5h+3BSww3JnITTM8Ur9l/ZHV
 4ZOGdwASB1NDfEUSdufc+4ErRTa0FzuuheEP8yMeLjhu03+NBv48WSlKjfpDwNroVzj1G/crLN5
 J2Gm4J6jkNdtCMz+Yv0meDwiOH99cBvJZfA6bRc8dUx6o7tOwTJaqWi3I9iIgWHrMCqMUgv/Xsi
 LQ1YYY5v5bnDhPEx0S8LdYAdGdOz2gIjktpi+VAhsZkox+e/wreq7Cpg1zenrAPWVgNlfmQXlUR
 R7jwkd9V7a8jNrxoh+9SbzR6lrDYt3xLiy3KeLz7BDn939yQKTc1n3YkzJsvPI2xeUCIhOayxOD
 Rtzh0FBWRfOXPa64k1Byctp2YQ+MlenmLpACTl0+TBoofmx87957aKjejT5DXbEo1K/9C2rJEf5
 XLlNXpOC2q79Es57gpeK5oTo6ISlsMA1uNKS8xddjjqXSZpkl2apXHyhrhOGTLLUQQQO4sBU3X
X-Received: by 2002:a05:620a:25cf:b0:8cd:6175:9b17 with SMTP id
 af79cd13be357-8e78f82b5e2mr4041913285a.3.1776963814671; 
 Thu, 23 Apr 2026 10:03:34 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d8edb734sm1869831585a.29.2026.04.23.10.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 10:03:34 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: patrickrobb1997@gmail.com, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1 0/8] dts: move test suite imports from framework to API
Date: Thu, 23 Apr 2026 13:03:12 -0400
Message-ID: <20260423170331.33193-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20240925192013.17446-1-jspewock@iol.unh.edu>
References: <20240925192013.17446-1-jspewock@iol.unh.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series moves various modules from the framework directory
to the API based on which are being imported by test suites.

These include:
  - test_suite
  - testbed_model
  - exception
  - utils
  - context
  - params

This eliminates all test suite framework imports except for
the remote_session imports in packet_capture, as well
as the settings/config imports in smoke_tests. I believe these
imports, and what to do with them, should be a topic of discussion
in future DTS meetings, as I don't believe they should reside in the
API, even if they are being imported in test suites.

In addition to these changes, I've split the linux_session module
into an interface in api/testbed_model/linux_session and an
implementation in framework/linux_session. This way, users
can still import linux session if necessary, without exposing
the backend implementation.

Dean Marx (8):
  dts: move test suite module from framework to API
  dts: move testbed model from framework to API
  dts: move exception module from framework to API
  dts: move utils from framework to API
  dts: move context from framework to API
  dts: move params directory from framework to API
  dts: separate Linux session into interface and logic
  dts: update API rst files for doc build

-- 
2.52.0

