Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2892C369AB
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 07:44:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D285402A1;
	Tue, 15 Apr 2025 09:44:56 +0200 (CEST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46]) by mails.dpdk.org (Postfix) with ESMTP id 2B9B840289
 for <dev@dpdk.org>; Tue, 15 Apr 2025 09:44:55 +0200 (CEST)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-5499614d3d2so5991351e87.3
 for <dev@dpdk.org>; Tue, 15 Apr 2025 00:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744703094; x=1745307894; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VJb/y7xuAmOBlhp8NTwWz6MMiwpQ0l2xTyInskcJY/c=;
 b=m7TiCmxVih3c7gdk2Z7G0/GMMtQE7s6Sp+PkXZt3MUp2QYFr2up2HwaEVpNfAjHWUj
 i1zoyYtr7Cv4ohUS+3aPAqiaNuzvnN4mqu2z43/K6WCSjcEjLWSw2oplhE/WIpcoyhP7
 AxmNeaxgUJDJZ8FEbcOt6hGW3HWpOeMpPASOqiH4ETeTsVh7ejzW+WBXdpPgGCJmDmgm
 PUZVDlguxttboXsbaEB2QMEyZvzNhQhf8X1Iq9nQDL+bGZTdkJpBAbsbkzGFugQqS1bS
 hjcWtj+UVvZcvvacjEs8HWrAMCz64r6QfeX1OTvjdxjOGZvlauwVL9Q8lSqnTpKRq2Lc
 sLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744703094; x=1745307894;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VJb/y7xuAmOBlhp8NTwWz6MMiwpQ0l2xTyInskcJY/c=;
 b=mi4X9I2YUreCnH28Who02oWSU7YrSp/2s2Q61z4Erqp5flrX+/tXdX2h2/bXbZB1t9
 H3nyMeGB1FgDkHecuFwQRYxiFP/hyAVoM8OMhBwnmwYpAq8X8KFEYvwNZKMKEgZEVj+k
 dp8gAEpxfFepxVVjzwcvEJ0/SitoIw8/2vN9JVEf10tPusT1YkcESxh7pKIacd15XUAf
 ael9bL+TsQzl4+9ITMWzmdR9Kb4N8WZ0E3SLdYuDxfoXt0nJy7fsR4PdWnDoeeL0cLoS
 +JRCFZUpYA659bpJ22d36JN3wQIlgZlFc8f13DfrU7l7jAmZkZCIRK9icd9xeJ7C3xQ/
 3fnw==
X-Gm-Message-State: AOJu0YxUrGFjkEcDBI2Rz21YKj0FQcpfLfR9Aa7jH/GP9KEg766lH/07
 b7Ft2Okg+D6s9cINjspJtF7k2wKlhB55x10Jjm0B4amlL1fZ/7zi
X-Gm-Gg: ASbGncv/7wnw/gexnKLnFo3qMHT2zeyCiQL7wlMDylWwhROOsHFhuZTcDI1fBLglZXa
 /kVLAYk6upT2LglmeHrvrUnOCo/jsadKXxpejcPC3OMER3CBaGVIH/lyNYsbDEhDEXvn6/P+aze
 MEOnsdWUPCD9EIRFFm/qDN22aME8cVxYdAc/gmGoN/6kG2CC1zhUe5guHy3dAcziC+xRAqFObwk
 z2C7eN2G/Qquz+/JEjNhZ4NkcMsfqqffBbQbKmHbfIuyHVDCHCD9QFn9khVUs+sjskJVLZyJubP
 xGmkvD/GPLaB6Hx5iVcQnPZEGrI4j8rsTzkGswtgAORnryWfxedJMhrABE17WDPZyroEoXr5ERN
 t+VoXTHMkTivXX742j4F2vQ==
X-Google-Smtp-Source: AGHT+IESqh1IJskulfYKdDHnPcPUdeakM03DN4/BSNsu7YpjEOmLYOcsDVPpVLBxLigOa3YMnyg6mQ==
X-Received: by 2002:a05:6512:6ce:b0:54b:117c:118c with SMTP id
 2adb3069b0e04-54d452d657emr4853194e87.57.1744703093940; 
 Tue, 15 Apr 2025 00:44:53 -0700 (PDT)
Received: from [192.168.88.232] (broadband-109-173-43-194.ip.moscow.rt.ru.
 [109.173.43.194]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54d3d12345esm1342623e87.29.2025.04.15.00.44.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 00:44:51 -0700 (PDT)
Message-ID: <b005ba52-afc4-4397-a754-f31c3ecdb33a@gmail.com>
Date: Tue, 15 Apr 2025 10:44:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] buildtools: use macro to embed information in
 binaries
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org
References: <1744400374-26620-1-git-send-email-andremue@linux.microsoft.com>
 <1744680096-17683-1-git-send-email-andremue@linux.microsoft.com>
 <1744680096-17683-3-git-send-email-andremue@linux.microsoft.com>
Content-Language: en-US
From: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
In-Reply-To: <1744680096-17683-3-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 15.04.2025 04:21, Andre Muezerie wrote:
> -_, tmp_root, ar, archive, output, *pmdinfogen = sys.argv
> +_, tmp_root, archiver, archive, output, *pmdinfogen = sys.argv
>   with tempfile.TemporaryDirectory(dir=tmp_root) as temp:
>       paths = []
> -    for name in subprocess.run([ar, "t", archive], stdout=subprocess.PIPE,
> +    if archiver == 'lib':
> +        archiver_options = ['/LIST', '/NOLOGO']
> +    else:
> +        archiver_options = ['t']
> +    for name in subprocess.run([archiver] + archiver_options + [archive], stdout=subprocess.PIPE,
>                                  check=True).stdout.decode().splitlines():
>           if os.path.exists(name):
>               paths.append(name)
>           else:
> -            subprocess.run([ar, "x", os.path.abspath(archive), name],
> +            subprocess.run([archiver, "x", os.path.abspath(archive), name],
>                              check=True, cwd=temp)
>               paths.append(os.path.join(temp, name))
>       subprocess.run(pmdinfogen + paths + [output], check=True)
Does `lib.exe` support `x`? Can't find this option in the doc:
https://learn.microsoft.com/en-us/cpp/build/reference/running-lib?view=msvc-170 

