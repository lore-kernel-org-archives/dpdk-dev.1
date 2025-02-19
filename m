Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E620C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 18:39:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9025E40263;
	Wed, 19 Feb 2025 19:39:55 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 4781E4014F
 for <dev@dpdk.org>; Wed, 19 Feb 2025 19:39:54 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-220c8f38febso572035ad.2
 for <dev@dpdk.org>; Wed, 19 Feb 2025 10:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739990393;
 x=1740595193; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+bFqfzhJKrgo6iwMoxNfRzUcNqn/pUeaAZGHc3gisxQ=;
 b=nwJrUTcCSNnWp91ReXYjq7aE5q5Zg4DYU+SMHZKJFNb85Cy4wnstm9cOrh6hVbSPxy
 qRBbpu7hqb1gYfW2hxHhgH6rd9lYNbA1b1zM2Iw0c+W1mUi7MOpuBbQm6lWY4HfcvDas
 obzUYJ67wpVrJb4SBqE1iZpk4aOb+h9yZogO/9+KIQATSSNAiw6qjxA3V1spAYkm7Iks
 P40KikUu1/nLskmPyJlsT0SvGNeum1fMnZzcN2YslfbesjBk1/erYxGQrVgiwb1bNdEL
 9wGdPN2iwj4USiedZOakVPSLa/1AlTMT3URHH2JhZ8zRIPxufErzKBYO8XqFFT2oxHJB
 ksMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739990393; x=1740595193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+bFqfzhJKrgo6iwMoxNfRzUcNqn/pUeaAZGHc3gisxQ=;
 b=f/1B/qYdTAkzFYYZ1p5lGKoPWLPN4L0Q0lSwoSDobL4w5Zm1bpnrYw0ZUKPiFyXaHZ
 KbMFJARVCAoQbem/+RC4BA42q2ew3rh1jTTTThMOncaaNnF7S5EDMDqyefGzdh48C6UN
 A6FRBLhy66UgArSfMMnKH7wbJEUKloHRv0Gzs2crAm3GS3jQM367xw4BVcXstcNfp3zU
 PzgUSNfiAGcYQpf0tV6GpHyhFwqlCLZ/foJOdCJMsyN3bSMA70/Vc1UW6xTW0FT+ucYc
 OYuWWDz1fG2trP/Irmy6xw+WPMCQZPKuglO9hjU1TF35sGx2Uz8k8Ios9VD046hsWmdG
 X5xg==
X-Gm-Message-State: AOJu0YxikRKBxdr639y/L5FUPQjE1L4npS3yefuPa8oEMj/9vLy7swWV
 DkXnqhrTmmPl6be87O3/YV0ccqnjLV5YChmdB/3zuAxlAqYSl1i801GOo8W2mEc=
X-Gm-Gg: ASbGncv8qnZ/sYk9qhV/h+4iIqDjfoRj63rNGzsE1CvVGpzf/MF4n8msh1uI7oaxiI0
 6vvhw3tbOGCzi1rrKNxO5qEDK8cO4hBuBEeQkI9r8i0fSdAjuMw9SilfwrFZs/OYMTKxaiegiUN
 TnGzmuswXmovhTbphK1uQmRfho3noIDNGTGxAKvwF4HrLPyEhNORNhKDsaD4eC4Xsbm3aoTb3yt
 04M98XGGjAnIdNxFXVDOzZKarX0vRsFsYiW35Rkr+ByUJmi6A65fgl4hVQQqjS+hfQxLP/vjvSH
 f9VtwMtlrHbhPvnE6WC0Eb0K4I7iqKlXpnCrtKEvtomdONr2di10N0/kwBMkh6RwJqeb
X-Google-Smtp-Source: AGHT+IFnjtKvyRopPv6xLfXN/eh6NDhtxG3gSLl5XAny+YoVJDS8Omgqs/eDAo52NkGkrhz36EHfHg==
X-Received: by 2002:a05:6a00:1816:b0:730:7970:1f8f with SMTP id
 d2e1a72fcca58-732617bfaa2mr23510507b3a.12.1739990393406; 
 Wed, 19 Feb 2025 10:39:53 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ade083277b3sm7769031a12.27.2025.02.19.10.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 10:39:53 -0800 (PST)
Date: Wed, 19 Feb 2025 10:39:51 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gregory Etelson <getelson@nvidia.com>
Cc: <dev@dpdk.org>, =?UTF-8?B?wqA=?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>
Subject: Re: [PATCH v2] testpmd: support meter_mark init_color in indirect
 list configuration
Message-ID: <20250219103951.5e9870bc@hermes.local>
In-Reply-To: <20250217172111.67655-1-getelson@nvidia.com>
References: <20250216140420.216805-1-getelson@nvidia.com>
 <20250217172111.67655-1-getelson@nvidia.com>
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

On Mon, 17 Feb 2025 19:21:10 +0200
Gregory Etelson <getelson@nvidia.com> wrote:

> Flow actions parameters in indirect actions list are created as
> read-only and shared between all flows that reference that indirect
> list.
> 
> If a flow rule needs to apply rule specific actions list parameters it
> does it with the indirect actions list conf parameter.
> 
> The patch allows flow rule to set meter_mark init_color value when
> meter_mark action was created in indirect actions list.
> 
> Example:
> 
> // create indirect actions list with meter_mark flow action:
> testpmd> flow indirect_action 0 create action_id 10 ingress \  
>   list actions meter_mark mtr_profile 20 \
>   mtr_state 1 mtr_color_mode 1 / end
> 
> // create a flow specific meter_mark init_color configuration:
> testpmd> flow indirect_action 0 create action_id 11 flow_conf \  
>    actions meter_mark_conf mtr_update_init_color red / end
> 
> // queue a flow rule with indirect actions list
> // and flow specific configuration:
> testpmd> flow queue 0 create 0 template_table 1 pattern_template 0 \  
>    actions_template 0 postpone no pattern eth / ipv4 / udp / end \
>    actions indirect_list handle 10 conf 11 / \
>    jump group 10 / end
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>

Looks good, would like a ack from one of the flow maintainers that
looked at the original patch. Those were:

    Signed-off-by: Alexander Kozyrev <akozyrev@nvidia.com>
    Acked-by: Cristian Dumitrescu <cristian.dumitrescu@intel.com>
    Acked-by: Ori Kam <orika@nvidia.com>
    Acked-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
    Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
