Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B35C624D3
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 14:28:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BAE6402DE;
	Wed,  2 Sep 2026 16:28:11 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id 9A15140262
 for <dev@dpdk.org>; Wed,  2 Sep 2026 16:28:10 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-84e84a6c4bfso1178179b3a.1
 for <dev@dpdk.org>; Wed, 02 Sep 2026 07:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788359289;
 x=1788964089; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HN9RQ4KisexVFTleyg8wLi3C9HAKV6BMxMcGeQVZvx0=;
 b=bhuWta+98f7Jh0G5ZuLvS2mzdGr1p31mhquHL/eRyFsoAkz1MgXTjTFBDcPKPmw0iZ
 sl1bDpzM+lqZ05Y2qney/PUaNUVg5xhlbCvLgl4+OKiBHhYS1iQVwNtfrPnm8EU8IBMv
 vFaYX1ORTe+xkpRG2v+ho+bgpZPWrvEw0XkMFqyaf4dDOoMGY1RM7lcZBVPRtXd/Me8y
 RhET8SvpgQXj6Ll/if4nAaNfI2sjcBmDCc/I1vtDAGNkxyDeYbn4xlleQ8LUQpPEQFqU
 ZnK0fHNOfXL0NgpBU82NDzur8I1inY4lQlNYYbIM0yRfq17MtnBYf/jZe4S7QL5ltSVi
 iLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788359289; x=1788964089;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HN9RQ4KisexVFTleyg8wLi3C9HAKV6BMxMcGeQVZvx0=;
 b=hR4iYoaxhmpDqt0YwgEqdRpkfreKQycJ76S9j5TE05EhqSkO6ZFFctzORpvneXm9xA
 nNkLB3WZzBxZe3kfdmTlXzSQYWqqedMOI8DPKujlGfxbUAIr4xbHzxGIx5ngffkMBOxt
 PSZYeBDDNmG+sGoCL3l9ZDLGumOVeRPoatxwrxJARZLpjROvHs0xAUY6kul2vQs7GwwE
 mNe9PjF4Mp8F+bFPW/Jmt0V8tE7MSJwjCeF2lVEYtECy6iLCEp9PY3+MumNtJigEV+TZ
 QZiqKm1SQyETLQf8sket6EgMd4z5jpTBACtHzityB4JmbIylpMV6iPWTlSLKbkCoU4JI
 XLTw==
X-Gm-Message-State: AFuF++n9gRXWYv3g30ZnByrjwjWLbAeXxbbmXrY8ILECwv1oPp0eKFWB
 Mcxl3Zaf9sp7dJzHi81ruL7ZmVMMPIfXmWicWdNDa4DlyCF1R2ZAxgOd9b8GLbPPkL5UV1xEGv2
 PQJQw
X-Gm-Gg: AYBFou0G8q+E1eJ0gDTWAmi9UpY0lR91lJMCN6O1CxSa55isCMQzZkEoj40o1ovTOBo
 0BSLQNh3ibIysHRrB/ZnyEyDDsYQhUn5YDzTA6td3si0CtD7h/ylzSAhc7WdpMOXNemoDU7GJQk
 /3gfyfNIbIQlatu0XA7zaeJw1I28BkLLGJgkHXUTA/j6gB5IN5IlP+oVtoMrQgp9xbSOu/PN7OE
 6aPXXOycrUs5yk3FegGLhcdjEQ+ajD8kiL5STuwot+scwS37dL471/mRLUscPGMfR5Rc+8/QwGh
 c/tl9kUP9THTAgP3DV+ZZx7sWi0aCPFE7aIWXPM8KJsKhT5yK7MyiGyNwuwUn3QRILIuH5a+g2i
 QPQ7ZofqgbPl9xg8LrbmIsPxgy+8nujyQgLpmeYKzst6AKHBeOymD7BvmXv2iF/eOpeoUUdGPlk
 MS6KvjRWgfeGTurnu5t/qxfdYGd621ot6qpouz+tkDuKo2luPm1BD9dqCJ8F4hjZHmAQs/WTcAn
 sGJOJJFBAPllQD13X1glcsKVqU1W2+J9Kc6/fblng==
X-Received: by 2002:a05:6a00:7099:b0:848:48d0:934 with SMTP id
 d2e1a72fcca58-85f448cdd36mr2537157b3a.18.1788359289421; 
 Wed, 02 Sep 2026 07:28:09 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85dc003ae8asm1485433b3a.32.2026.09.02.07.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:28:08 -0700 (PDT)
Date: Wed, 2 Sep 2026 07:27:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 00/48] net/sxe2: re-align with reference and fix
 review findings
Message-ID: <20260902072759.2eb18f92@phoenix.local>
In-Reply-To: <20260902015649.74716-1-liujie5@linkdatatechnology.com>
References: <20260901031006.3686638-1-liujie5@linkdatatechnology.com>
 <20260902015649.74716-1-liujie5@linkdatatechnology.com>
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

On Wed,  2 Sep 2026 09:56:49 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> This series updates the SXE2 poll mode driver (drivers/net/sxe2) and
> its common library (drivers/common/sxe2), fixing issues found in the
> previous version and re-aligning the driver with the reference
> implementation.

Very very close to being ready.

Two things left.


Patch 35/48: refresh link state on link change events
-------------------------------------------------------

Warning: the commit message says the call is removed from
sxe2_link_update_init().  It is not removed, it is made conditional:

	ret = sxe2_drv_mac_link_status_get(adapter);
-	if (ret) {
+	if (ret)
		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to get link status, ret=%d", ret);
-		goto l_end;
-	}
-
-	(void)sxe2_link_update(dev, 0);
+	else
+		(void)sxe2_link_update(dev, 0);

Keeping it is fine, the initial link state still has to come from
somewhere.  Please just say that in the message instead of saying the
call is removed.


Patch 48/48: fix devargs parse error check for representors
-------------------------------------------------------------

The check itself is correct.  rte_eth_devargs_parse() returns the
number of devargs parsed on success and a negative errno on error, so
"ret < 0" is right and the old test did break representor probing.

Warning: the error path below it still returns something else:

		if (ret < 0) {
			PMD_LOG_ERR(INIT, "Failed to parse device arguments: %s",
				dev->devargs->cls_str);
			return -rte_errno;
		}

rte_eth_devargs_parse() returns the error code directly, it does not
set rte_errno.  If rte_errno happens to be 0 here, this returns 0,
and sxe2_eth_pmd_probe() tests "ret != 0" and carries on with an
empty eth_da.  A parse failure then looks like a successful probe.

The line is not touched by the patch, but this patch is the one
fixing the error handling of that call, so please fix it here too:

	return ret;

in both places.
