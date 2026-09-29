Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188CFCA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:44:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7EAD42F93;
	Tue, 29 Sep 2026 18:40:08 +0200 (CEST)
Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com
 [74.125.228.37]) by mails.dpdk.org (Postfix) with ESMTP id 8A70042ED8
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:56 +0200 (CEST)
Received: by mail-pz2-f37.google.com with SMTP id
 d2e1a72fcca58-886a5cb66beso14545b3a.2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699936;
 x=1791304736; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+3qyCdqIWL/PVCNyHFpXdONh3fm8Sb5qZOA0FHeH9Lk=;
 b=hRyeobSD2jH7O03lXqxuaWesgAiix81LaQCsPHmBMJI2F4TNt8UJCopdIg1qoniant
 JDqkcr4Udlx+14AG+WQbtsMydg5PwKgolTGwcoN2+EnZI7QCHVKhBvTHF1IfNQkB0vYl
 J9ftg9n2vRQW8c8O8q2fOyDAeiHf6KH1E4i+BQpWYEOO+smn2gqLpJ5JQ8sl+e8eRWCQ
 3i8g4nZE3/oqSTZm/CD75idoMbBhJzqS77f9vjnN+117AC5ND2spW7to3ikOJX7NFhes
 KrWejquiZPzRe9uET++PW9vY1JZEaGSl7Nb1bw7zDGd9I5FgOvbcm3YpeID0yor/UPJb
 oofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699936; x=1791304736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+3qyCdqIWL/PVCNyHFpXdONh3fm8Sb5qZOA0FHeH9Lk=;
 b=hp34/cPaViXZ5cqk+l2xewCIPLs8UE5x9/FSMhYj0RCu2G7+HBMmL/HKHDY29AKQPA
 onjBpwfofQI5ClWl+jBd/iEmurE+M+Le8dc2vshpPx3zKDYbxlkwjDz+yL58QfUhzFns
 C9BU0hi+wHQOaCqIMKHw3S5qUabsvSEKi69E8RIZ+yURpzsD5fPNpM6n1Q1aEkKQpCXR
 GMz1WAPNKioGi4I9hn/PB/ALPtPNCLJmJgV41Vth6PizzikE0/IentkJk16eUyL+T2Sg
 OEz9jZNv4oGo2NDz41lyaoVo8jVjvfKzG9iO3BrwqhsOsuZQLQDYZ+hGvRisRj/NgD92
 0dMQ==
X-Gm-Message-State: AFuF++l/as/gYhcJtLvBn1Y78EQefnHuQxahi+Q8rcvEnSa1L52P+apu
 GM6Xb8HtOOfKvK+uashourO0cFkJNI61MFw0guN837b/0YryecrIFUHkTcOWh2qMHA2uOAALIQ7
 odekm9lE=
X-Gm-Gg: AYBFou0kI02evDOjy/wsuYRxWiQruXujqqcJBFELrJQf2+Rg/i2Q2Abv/nYi2Fwu6Hb
 M3YwsFP+CHktiVmKBFfuaZmPzVIR3jHlPofP7SsnJF+JEaz2qVxi17g1UMJGffA4JQ8B/5nRo4z
 H9S4cjSBmdDHuqEA1xe81tCL3hzPeHyHTuUODG1UjvirjlpfpYzOWWV9P/lzKAVdG9iqQeEtgqp
 yctEkgTnSosKKnJ7w7Z0z2KCweB8OFFKQkCUAiQVKXygeUb5UoWCmYaRHfkRGWCf3G21uskqImd
 wER/L2c/TyhVsBWEC4hOZiVoEDrUU/kNO/+wbGF/zC3OnOQaJ4+Wy8rfYl4ucwS3RXqC7Gdi3zl
 H2uVYFm4tNj8c0i2g9qyq+EKCYLaT/p/1vDTolRgdWp3TpO+3LWVp1MkzsHk/TE5kAJzPsqd/Gk
 JqgT5hvaz0aCnIhPRq5IMSruBwCaoO8TO1kh260fDW+kYD5V4pN4l+9AOT+/4nP5mNeXO0842Uw
 droAFiDqfjuHHViSxANnjp7dNzI1iCnQX1GEw==
X-Received: by 2002:a05:6a00:194d:b0:885:f267:b361 with SMTP id
 d2e1a72fcca58-885f267b6f6mr1667142b3a.0.1790699935623; 
 Tue, 29 Sep 2026 09:38:55 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH v2 54/61] baseband/turbo_sw: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:57 -0700
Message-ID: <20260929163800.1108305-55-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

parse_u16_arg() never checked the end pointer, so a value such as "8junk"
was accepted, and it used base 0, so a leading zero silently selected
octal.

It was also used for both device arguments, but only queues_num is a
uint16_t; socket_id is an int, so parsing it wrote two bytes into a four
byte object and left the rest uninitialised.

The handler did nothing beyond a range checked store, so drop it and pass
rte_kvargs_handle_u16() and rte_kvargs_handle_socket_id() directly, each
matching the width of the field it fills.

The open coded range check only tested the upper bound, so a negative
socket id such as -5 was accepted and used. The helper checks both ends,
accepting -1, which is SOCKET_ID_ANY, through RTE_MAX_NUMA_NODES - 1, so
the check is now redundant and is removed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 .../baseband/turbo_sw/bbdev_turbo_software.c  | 29 ++-----------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/baseband/turbo_sw/bbdev_turbo_software.c b/drivers/baseband/turbo_sw/bbdev_turbo_software.c
index 2cab495294..d6801d9123 100644
--- a/drivers/baseband/turbo_sw/bbdev_turbo_software.c
+++ b/drivers/baseband/turbo_sw/bbdev_turbo_software.c
@@ -1835,25 +1835,6 @@ dequeue_enc_ops(struct rte_bbdev_queue_data *q_data,
 	return nb_dequeued;
 }
 
-/* Parse 16bit integer from string argument */
-static inline int
-parse_u16_arg(const char *key, const char *value, void *extra_args)
-{
-	uint16_t *u16 = extra_args;
-	unsigned int long result;
-
-	if ((value == NULL) || (extra_args == NULL))
-		return -EINVAL;
-	errno = 0;
-	result = strtoul(value, NULL, 0);
-	if ((result >= (1 << 16)) || (errno != 0)) {
-		rte_bbdev_log(ERR, "Invalid value %lu for %s", result, key);
-		return -ERANGE;
-	}
-	*u16 = (uint16_t)result;
-	return 0;
-}
-
 /* Parse parameters used to create device */
 static int
 parse_turbo_sw_params(struct turbo_sw_params *params, const char *input_args)
@@ -1869,20 +1850,14 @@ parse_turbo_sw_params(struct turbo_sw_params *params, const char *input_args)
 			return -EFAULT;
 
 		ret = rte_kvargs_process(kvlist, turbo_sw_valid_params[0],
-					&parse_u16_arg, &params->queues_num);
+					rte_kvargs_handle_u16, &params->queues_num);
 		if (ret < 0)
 			goto exit;
 
 		ret = rte_kvargs_process(kvlist, turbo_sw_valid_params[1],
-					&parse_u16_arg, &params->socket_id);
+					rte_kvargs_handle_socket_id, &params->socket_id);
 		if (ret < 0)
 			goto exit;
-
-		if (params->socket_id >= RTE_MAX_NUMA_NODES) {
-			rte_bbdev_log(ERR, "Invalid socket, must be < %u",
-					RTE_MAX_NUMA_NODES);
-			goto exit;
-		}
 	}
 
 exit:
-- 
2.53.0

