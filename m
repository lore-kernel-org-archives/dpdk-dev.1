Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22624CD6E49
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 May 2026 20:38:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 297EA4029F;
	Sat, 30 May 2026 22:38:06 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 8E8B44027F
 for <dev@dpdk.org>; Sat, 30 May 2026 22:38:04 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-91550eced6bso14672085a.1
 for <dev@dpdk.org>; Sat, 30 May 2026 13:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780173484; x=1780778284; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZTq4njVxg8OBm+hjiG1NtB0vGhlHrlwgA9muuQuS2II=;
 b=eT6p+k2vjCIQBnG7+ABJe699GJcYqHQ+KEukRgl6sBFs3axykdUsurNsvvK3CDkzuG
 Ey+Vr2EacmowiRkQhJuaG7dM86SXnXsOyuOR1RlefcQC2UQlzaPUSMUn16383zNF44Z3
 bEeDSnRAMU/Kz2WGgnbD8GY8cdIkuqJEsZ8XlGsSOaYgMmUoS394TRLnUV5Jfq7tW6Or
 sTihNARKpDSd/2tkzgbS7Uu6pmTeuC1lZNLB0Hv7WwMgdCsXuh0cSeilP9lSgmcWFtIf
 bNgoe+5WKDnOse3WZpE9HfdMxtv7y69/iK37OvFrJqLRyaDAx1NbvdxRwD8Mp5ABYRVA
 b+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780173484; x=1780778284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZTq4njVxg8OBm+hjiG1NtB0vGhlHrlwgA9muuQuS2II=;
 b=m6N63tU9Kr/d8SSe6/ydDNho1FM4L6D9GfqRjN+ahvF0Y1XxewjHSGIWmyDpdtNvh/
 4Upg1aXBRYMgDZqTDRaTb3EJZ+FNcdjfC50PreSAmZSfT9OTrN3v07uu7vSeKtLaQtey
 L3wMiZMxChaEruziFA584DM5oCA+J/nI0I7bAKlQDDzPKyT5kJq8qyk/q1SkHoE5FVBC
 vkX4A9cSWLqBE1jbyu8oSvwsVWlB4PZ3UPzRfUbnlLAxTY/k+tWi+c1468+1hNrRKDQg
 vdqj7sSnG9YLLfJ4RT+WMr+zG60y2C37jSebF81cWQkgl6suJPjnb7E4kfLZHksQyQag
 GbPg==
X-Gm-Message-State: AOJu0YyKnIpIWqqvSw0+964urzKd8XFm0i3a+L7ps9ChrOttj6wj93lH
 RUWCw+4sZ4HqGdoL+FQlehR1aLp4whtLXWBznZalPiVb7DqVRb4lNQW2
X-Gm-Gg: Acq92OGIf7eWODwnXhnto8hiA8FszIgwtI1IsoNia60JPFvtnrCROYUPaZU9cxOQ+Ok
 4CGlX2M4OytjqYCeBiVRnH4pTr0r5mAdSjYVmJARpCYpwWUo4L2jLsmn7I2cqTYqHP4oJACgn02
 JYLInzREsBia9d7JU1efIxL2pwTWvAIkgCovcBAGmbO386kxawJc3JltDNEOO/AIOei1v0u5qOD
 zBES0RJbDxfsvWl0RhOpzsEsdbKpEpvwbpd4XGAn1PX8KEm/7rTK07IlabK5DoaiXhRIffqu5az
 gtnVY0kOYfd124oBPAOzJVB+98PTqvBOLK2o/82PKKk97Ms/yOr+G610Zb8w3MsbOU45dpykHsR
 oBm7VODMgpRsq69XDNbzLQHVVUlkVx0O2qKnVD2mftm3OzzqXxBW0a2mU4MGmUedfivyInxxKqZ
 n8uJC6APIGeNuee0nYaBYVeODNP9RJg8X529TEAevo+8kQXShGgrC3fySO85ahFJLj/+VZSR5gi
 Ue5b0M1nOAN4aEMryGaoxQuXBbiYA==
X-Received: by 2002:a05:620a:a2cb:20b0:912:67ca:bab7 with SMTP id
 af79cd13be357-9153d938bbemr534093185a.2.1780173483797; 
 Sat, 30 May 2026 13:38:03 -0700 (PDT)
Received: from blam-mobile.hsd1.nh.comcast.net
 ([2601:188:c083:cd0:c107:2c35:5b4a:5cad])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-915326503d2sm573400985a.44.2026.05.30.13.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 13:38:02 -0700 (PDT)
From: Patrick Robb <patrickrobb1997@gmail.com>
To: abailey@iol.unh.edu
Cc: dev@dpdk.org, dmarx@iol.unh.edu, luca.vizzarro@arm.com, probb@iol.unh.edu,
 Patrick Robb <patrickrobb1997@gmail.com>
Subject: Re: [v2] dts: add support for no link topology
Date: Sat, 30 May 2026 16:37:57 -0400
Message-ID: <20260530203757.22139-1-patrickrobb1997@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260224163200.39360-1-abailey@iol.unh.edu>
References: <20260224163200.39360-1-abailey@iol.unh.edu>
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

 from pathlib import Path, PurePath
 from typing import ClassVar, Final
 
+from api.capabilities import LinkTopology
 from framework.config.test_run import (
     DPDKBuildConfiguration,
     DPDKBuildOptionsConfiguration,
@@ -263,7 +264,8 @@  def _build_dpdk(self) -> None:
         ctx = get_ctx()
         # If the SUT is an ice driver device, make sure to build with 16B descriptors.
         if (
-            ctx.topology.sut_port_ingress
+            ctx.topology.type is not LinkTopology.NO_LINK
+            and not ctx.topology.sut_port_ingress
             and ctx.topology.sut_port_ingress.config.os_driver == "ice"
         ):



I don't understand the change above. Surely we do want to set the custom meson args for ICE DUTs when there is a sut_port_ingress, not when there isn't a sut_port_ingress, right?

Also, does the topology type affect whether we want to use these custom args, if the SUT driver is ice? I guess in a weird case we could have an ethdev test using an ice DUT which does not need a TG?

Reviewed-by: Patrick Robb <patrickrobb1997@gmail.com>
