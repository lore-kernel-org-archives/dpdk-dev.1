Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB56EC982DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 10:16:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1FBE4029B;
	Mon, 21 Sep 2026 12:16:14 +0200 (CEST)
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com
 [74.125.228.76]) by mails.dpdk.org (Postfix) with ESMTP id 51ECA4021F
 for <dev@dpdk.org>; Mon, 21 Sep 2026 12:16:13 +0200 (CEST)
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a9984f9adcso4704740a12.0
 for <dev@dpdk.org>; Mon, 21 Sep 2026 03:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789985773; x=1790590573; darn=dpdk.org;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:content-type:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NBVZASMslchUwY0qEwL02IWKbvhq0iZtfD003kFKHIs=;
 b=KhgvP5x4zISwnG9oVSxwLzOrlcErDafMk1v5lWXUFHinvohSfcUAWdvFdIaDbmNbt2
 wIU6VsencWVVqBsVQUMOWSQ/wCDaVaNEm83l1LXNMH3YawByXgJGhmYayCihV2ZLP8l/
 kl2ykWA/pU7Kn8GTt+KUV8dfrWy7A4jq5kONxB8xpzpgmRe2qk5DuX73nO052nN2nks5
 VHZUQlvjYqCcw54wL9gQNPac/iefSwmAVUisAJTMNmVG9SzLxfMy1jHRS7nRwCgR3wuC
 /Uxc+tfphrZkwZl9sFa0o+qsscTyli1+jUpmqdGpYkhQXD6rqo/3WwWzZW+hq2sYL1xy
 Zvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789985773; x=1790590573;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NBVZASMslchUwY0qEwL02IWKbvhq0iZtfD003kFKHIs=;
 b=wWgYxyojI3o8DyLhGpfCzDt4qvh9qyBnHJ3PfarlNu8mCNTlRFoUBjENVjGrt8G3oC
 U2DCbMbBRxOuq8PbygRYZG9ZGrVzrwADqYyB6yBDpsqhCR3f7FnNzBAV3kr5+qnFQnAD
 +kv6o5VxrFiIqTziDu6mT1te4HBuaffC3li63+gc7EonvMp08FxIfTlUDRxEfArTN/Ze
 erqUWuUEvDOh1ftCb29hvoxcJ4fl4yRr/DhhYPMASaPBjnu9b1Cyz0QwgDRcAeQZWCSz
 lRka5DG0IbEXaSMtoSEZHVvbgR1PGNV4Oc8+yocQWy+ikQR1Shzr9h2RKod+NlVzs2TM
 4Xfw==
X-Gm-Message-State: AFuF++mKI5/yQi1B95hUv4QXYU7kA9KO9M7qDqDAxSWMtdcObLJT3Vp7
 jfjvaGmAjvYcf/VXOsyXWnz6lRkc4pAHcTHeP9FGdCkusaqkRX1yKTKW2HPRAU5o
X-Gm-Gg: AYBFou2NO2SnN6HIWFhclYpVzWgjUk2B+r9/Okf/7RnB7wYBhUT/TjYpc77Hr3REIWJ
 bIGFb/NelXNjlfSshdogvJm7bz+1t2iSrFyu5+XFZgmK9aYjC/Hc/L/a0ZnG3wW927CcWZ/JRWM
 qGGokzKM6qdhufWRDhH7rbieWJAv0CRrazMXD2p+vN3AEj7i5MaDu2ySwox4OEczNz/e18MErHX
 dUE6tdX7cknRqFg/EjxCjZLnHzixSZnYf1UnDtO2LtEpsaS9JQxKhI8c0HILrutud9+83zJd/oj
 BL5B7DkhwFqLLhc9/MUpv+MbH8Vg8JMx6SHxF9tMncfIQOlt3FZYbOn7UF0fGziynKF9bXgoyNA
 8th1RTiA6xwL52SebJ7nrDzfBZWWyDTqO97wJpT6cJI1dTXX3q1OMMPXuVVQkCVMaw7mwkJzoAt
 fpV3FpDCI5h/33T7IMA3JD3QXzMMxhcXIPCTrHNprbG9P+vqCzFwSkFFh4bUwaffz9OnchhCJqt
 EsKgAtHuw==
X-Received: by 2002:a05:6402:a0dc:b0:6aa:1c28:81b6 with SMTP id
 4fb4d7f45d1cf-6aa565035b4mr6756339a12.17.1789985772596; 
 Mon, 21 Sep 2026 03:16:12 -0700 (PDT)
Received: from [192.168.103.32] ([89.101.57.120])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa8d2739d6sm1021502a12.3.2026.09.21.03.16.11
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 03:16:11 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------KXlkVLbxwmb0Mj5lLq2jhjus"
Message-ID: <041727c3-dbe2-432f-920d-d9be213a015e@gmail.com>
Date: Mon, 21 Sep 2026 11:16:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] bpf: make bpf_def.h private
To: dev@dpdk.org
References: <20260917151916.48749-1-qm2k21@gmail.com>
 <20260918092117.74231-1-qm2k21@gmail.com>
 <20260918092117.74231-2-qm2k21@gmail.com>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <20260918092117.74231-2-qm2k21@gmail.com>
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

This is a multi-part message in MIME format.
--------------KXlkVLbxwmb0Mj5lLq2jhjus
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

|Recheck-request: rebase=main, |iol-unit-arm64-testing

--------------KXlkVLbxwmb0Mj5lLq2jhjus
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <pre><code>Recheck-request: rebase=main, </code>iol-unit-arm64-testing</pre>
  </body>
</html>

--------------KXlkVLbxwmb0Mj5lLq2jhjus--
