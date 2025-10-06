Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FCBCCA471
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 12:48:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5888402D1;
	Mon,  6 Oct 2025 14:48:06 +0200 (CEST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com
 [209.85.221.178])
 by mails.dpdk.org (Postfix) with ESMTP id 2753C402B1
 for <dev@dpdk.org>; Mon,  6 Oct 2025 14:48:05 +0200 (CEST)
Received: by mail-vk1-f178.google.com with SMTP id
 71dfb90a1353d-54bbe260539so1871379e0c.0
 for <dev@dpdk.org>; Mon, 06 Oct 2025 05:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1759754884;
 x=1760359684; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w0IV4QpvH/GVUECSxlOzp+zVtXDhPiDWsEO+suFBKGc=;
 b=xXXS++XG35cOjBAHW4Xxr4jcL4lMsirePUgh3Rw+282Z63P28QKt7p5p8csSRA0IND
 rpafTZiwpalK0Pa9YIYBEgMh0lPDIRB05S9SNgPpTCL5xe42w+5Lbs4dUQKZEnGDcrW7
 Q6xnLy4OtZM4jFXSavcJZ5eblaMJk47fFtqufUw30ljHj0Ouc3XYh1/3Ekudx1fedVK7
 ZzyTXYwKRXa+kry+lnj+rsAg2W3BMASZAQKAaiJk4tNXu83zAZGqHyTqm0FvgMymOPRd
 dQz3u02sZuMb6sbmM6s7OpozpwAh5ZkEdrN1EUp126bpfEqqBYAY3X2HxQgLBHb/jN/f
 IYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759754884; x=1760359684;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w0IV4QpvH/GVUECSxlOzp+zVtXDhPiDWsEO+suFBKGc=;
 b=TFgXuR5aNUr2YtwoHaXiGHEqy1VS5KpLmNPFvgHGE+vebwuKcWRaV+dhuDI6+ZzW+J
 z26lpn071WP4z3PI8ZKvB0IVRixzAL159Xxvrf0W+P6i/a6XANHFq/5occLIcGxWI9l1
 aiGeQMAdYWq8WZ+TQHXeRYR3QaL4BVeS+HeqoPmz9sS3BUycCIzJk1lqkEUCJGh8u3Ow
 yF7dpugnUteHmH+KcpTJB1kboQxyLJZe6m9eg2U6bjwvf5bbLJ9UNGOPrU6TMuU5bbUS
 +N6g5US3I9V0RPaCnaa3g78l6eoyHljryMFKaWkuh8kVhQ/MaKyxpbVK1zGOAVRxthzE
 frwg==
X-Gm-Message-State: AOJu0YxeWh3eaV7zXKOGF2ABQsCe3Zrz6VhglfEDjXT3BLRJOZcVqGvh
 SoedcwaAC+cIacXcWBf8iJM7N99B64qxGq+0rik1QJXdcDf2C2PadMGxns72ljV4yCnI0CV4Lou
 656RgtVVRhN+mp8HXgPOc5CcWnIGL06AM+xe8RZTFFQ==
X-Gm-Gg: ASbGncv/YKN9E0Py5JCkbsrf5FDzD2YLyKCjKyzuDo9ueZohAWB0VoJVMVypW961jJc
 qOPZBGPK9g9VeadK0fKpfrQ3MY5xgzLwUAW0TV4M5zaqrPhGLBtGfE9Bntj8bKCGD41ZrVXv8Kz
 ZoHb7FUnOe3HZGXmgoM5aGCaymF7aQBm4ELc+lUnnXb3F6Zyuepqf8JLnIl9kU667fqyAcPEN9B
 W32BvFMAVQspL5RKy5mxap1Pb+E/REDw6Mo+uLg
X-Google-Smtp-Source: AGHT+IGdslDkK7oeXbTfmM13d78kYSZrBVNY0gwrBusLg6o/c4i6UhmfPfvnIGE4XAkaDEqjqr8ZCcnTsCBnJ514ZDc=
X-Received: by 2002:a05:6122:3c8e:b0:54a:71f6:900f with SMTP id
 71dfb90a1353d-5524e41f745mr3614429e0c.0.1759754884261; Mon, 06 Oct 2025
 05:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <203d7186.13d6.199b3a225b3.Coremail.bloodyevil@163.com>
In-Reply-To: <203d7186.13d6.199b3a225b3.Coremail.bloodyevil@163.com>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Mon, 6 Oct 2025 14:47:54 +0200
X-Gm-Features: AS18NWAH9KwyKdiaJgSacdVuxS8mTi5GNOnHqbN5ndvbuZGewCgtiY4xVM3u1y4
Message-ID: <CAOaVG14QPhuJdD9BCnXQi14NFhMob-4jh4jfn2o0moZVyN7pGA@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtVUkdFTlRdIENyaXRpY2FsIElzc3VlOiBDaGVsc2lvIE5JQyAoY3hnYmUpIGZhaQ==?=
 =?UTF-8?B?bHMgdG8gc2VuZCBaZXJvLUNvcHkgcGFja2V0cyBhbmQgcHJvdmlkZXMgaW5jb21wbGV0ZSBIVyBvZmZs?=
 =?UTF-8?B?b2FkIGluIERQREsg44CQ57Sn5oCl5oqA5pyv6Zeu6aKY44CRQ2hlbHNpbyDnvZHljaEgKGN4Z2JlKSA=?=
 =?UTF-8?B?5ZyoIERQREsg5Lit5peg5rOV5Y+R6YCB6Zu25ou36LSd5YiG54mH5YyF5LiU56Gs5Lu25Y246L295Yqf?=
 =?UTF-8?B?6IO95LiN5a6M5pW0?=
To: bloodyevil <bloodyevil@163.com>
Cc: dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000c4b91a06407cdcca"
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

--000000000000c4b91a06407cdcca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

UGxlYXNlIHB1dCB0aGlzIGluIGEgYnVnemlsbGEgcmVwb3J0Lg0KDQoNCk9uIE1vbiwgT2N0IDYs
IDIwMjUsIDEyOjAwIGJsb29keWV2aWwgPGJsb29keWV2aWxAMTYzLmNvbT4gd3JvdGU6DQoNCj4g
KkRlYXIgRFBESyBEZXZlbG9wbWVudCBUZWFtIGFuZCBDaGVsc2lvIFN1cHBvcnQgVGVhbSwqDQo+
DQo+IFdlIGFyZSB3cml0aW5nIHRvIHJlcG9ydCB0d28gc2V2ZXJlLCBmdW5kYW1lbnRhbCBpc3N1
ZXMgd2UndmUgZW5jb3VudGVyZWQNCj4gd2hpbGUgdXNpbmcgQ2hlbHNpbyBUNS9UNiBzZXJpZXMg
TklDcyAod2l0aCB0aGUgY3hnYmUgUE1EKSBpbiBvdXINCj4gaGlnaC1wZXJmb3JtYW5jZSByZWFs
LXRpbWUgYXVkaW8gc3RyZWFtaW5nIGFwcGxpY2F0aW9uLiBUaGVzZSBwcm9ibGVtcw0KPiBwcmV2
ZW50IHVzIGZyb20gbGV2ZXJhZ2luZyBjb3JlIERQREsgZmVhdHVyZXMgYW5kIHJlcXVpcmUgeW91
ciB1cmdlbnQNCj4gYXR0ZW50aW9uLg0KPg0KPiAqSXNzdWUgIzE6IENvbXBsZXRlIEZhaWx1cmUg
dG8gVHJhbnNtaXQgWmVyby1Db3B5IChNdWx0aS1TZWdtZW50KSBQYWNrZXRzKg0KPg0KPiBUbyBh
Y2hpZXZlIHRoZSBsb3dlc3QgbGF0ZW5jeSwgd2UgYXJlIHVzaW5nIHRoZSBzdGFuZGFyZCBEUERL
IHplcm8tY29weQ0KPiBtZWNoYW5pc206IGF0dGFjaGluZyBhbiBleHRlcm5hbCBzaGFyZWQgbWVt
b3J5IGJ1ZmZlciAoZnJvbSBydGVfbWVtem9uZSkNCj4gY29udGFpbmluZyBvdXIgYXVkaW8gcGF5
bG9hZCB0byBhbiBtYnVmIGhlYWRlciB1c2luZw0KPiBydGVfcGt0bWJ1Zl9hdHRhY2hfZXh0YnVm
LiBUaGlzIGNvcnJlY3RseSBjcmVhdGVzIGEgKm11bHRpLXNlZ21lbnQgbWJ1ZiogKG5iX3NlZ3MN
Cj4gPiAxKS4NCj4NCj4gSG93ZXZlciwgd2UgaGF2ZSBmb3VuZCB0aGF0IHRoZSAqY3hnYmUgZHJp
dmVyIGlzIGNvbXBsZXRlbHkgdW5hYmxlIHRvDQo+IHRyYW5zbWl0IHRoZXNlIG11bHRpLXNlZ21l
bnQgbWJ1ZnMqLiBBbnkgYXR0ZW1wdCB0byBzZW5kIHN1Y2ggYSBwYWNrZXQgdmlhDQo+ICBydGVf
ZXRoX3R4X2J1cnN0IGZhaWxzIChyZXR1cm5zIDAgb3IgcmVzdWx0cyBpbiBzaWxlbnQgcGFja2V0
IGRyb3BzKSwNCj4gcmVnYXJkbGVzcyBvZiB3aGV0aGVyIGhhcmR3YXJlIG9mZmxvYWRzIGFyZSBl
bmFibGVkIG9yIGRpc2FibGVkLiBUaGUgY3hnYmUNCj4gIFBNRCdzIGNhcGFiaWxpdHkgcmVwb3J0
ICh0eF9vZmZsb2FkX2NhcGEpIGNvcnJlY3RseSAqZG9lcyBub3QgaW5jbHVkZSoNCj4gdGhlIFJU
RV9FVEhfVFhfT0ZGTE9BRF9NVUxUSV9TRUdTIGZsYWcuDQo+DQo+IFRoaXMgbWVhbnMgdGhhdCBm
b3IgdGhlIGN4Z2JlIGRyaXZlciwgdGhlIHN0YW5kYXJkIHplcm8tY29weSBwYXRoIGluIERQREsN
Cj4gaXMgZW50aXJlbHkgbm9uLWZ1bmN0aW9uYWwuDQo+DQo+ICpJc3N1ZSAjMjogSW5jb21wbGV0
ZSBIYXJkd2FyZSBDaGVja3N1bSBPZmZsb2FkKg0KPg0KPiBGb3JjZWQgdG8gYWJhbmRvbiB6ZXJv
LWNvcHksIHdlIGltcGxlbWVudGVkIGEgInNpbmdsZS1jb3B5IiB3b3JrYXJvdW5kIGJ5DQo+IHVz
aW5nIHJ0ZV9tZW1jcHkgdG8gY3JlYXRlIGEgY29udGlndW91cywgc2luZ2xlLXNlZ21lbnQgbWJ1
Zi4gV2hpbGUgdGhpcw0KPiBhbGxvd3MgcGFja2V0cyB0byBiZSB0cmFuc21pdHRlZCwgd2UgZGlz
Y292ZXJlZCBhIHNlY29uZCBjcml0aWNhbCBpc3N1ZTogKnRoZQ0KPiBoYXJkd2FyZSBjaGVja3N1
bSBvZmZsb2FkIGZ1bmN0aW9uYWxpdHkgaXMgaW5jb21wbGV0ZSouDQo+DQo+IFNwZWNpZmljYWxs
eToNCj4NCj4gICAgMS4NCj4NCj4gICAgV2Ugc2V0IHRoZSBmdWxsIG9mZmxvYWQgZmxhZ3Mgb24g
dGhlIG1idWY6IG0tPm9sX2ZsYWdzIHw9DQo+ICAgIFJURV9NQlVGX0ZfVFhfSVBWNCB8IFJURV9N
QlVGX0ZfVFhfSVBfQ0tTVU0gfCBSVEVfTUJVRl9GX1RYX1VEUF9DS1NVTTsuDQo+ICAgIDIuDQo+
DQo+ICAgIFdlIHplcm8gb3V0IGJvdGggdGhlIElQIGFuZCBVRFAgY2hlY2tzdW0gZmllbGRzIGlu
IHRoZWlyIHJlc3BlY3RpdmUNCj4gICAgaGVhZGVycyBiZWZvcmUgdHJhbnNtaXNzaW9uLg0KPiAg
ICAzLg0KPg0KPiAgICBQYWNrZXQgY2FwdHVyZXMgcmV2ZWFsIHRoYXQgb25seSB0aGUgKlVEUCBj
aGVja3N1bSogaXMgY29ycmVjdGx5DQo+ICAgIGNhbGN1bGF0ZWQgYW5kIGZpbGxlZCBpbiBieSB0
aGUgaGFyZHdhcmUuIFRoZSAqSVAgY2hlY2tzdW0qIGZpZWxkDQo+ICAgIHJlbWFpbnMgemVyb2Vk
LCBjYXVzaW5nIHRoZSBwYWNrZXQgdG8gYmUgdHJlYXRlZCBhcyBpbnZhbGlkIGFuZCBkcm9wcGVk
IGJ5DQo+ICAgIHRoZSBuZXR3b3JrLg0KPiAgICA0Lg0KPg0KPiAgICBGb3IgdGhlIHBhY2tldCB0
byBiZSB0cmFuc21pdHRlZCBzdWNjZXNzZnVsbHksIHdlIGFyZSBmb3JjZWQgdG8gKm1hbnVhbGx5
DQo+ICAgIGNhbGN1bGF0ZSB0aGUgSVAgY2hlY2tzdW0gaW4gc29mdHdhcmUqIChpcF9oLT5oZHJf
Y2hlY2tzdW0gPQ0KPiAgICBydGVfaXB2NF9ja3N1bShpcF9oKTspIHdoaWxlIGtlZXBpbmcgdGhl
IFVEUCBjaGVja3N1bSBmaWVsZCB6ZXJvZWQgZm9yDQo+ICAgIGhhcmR3YXJlIG9mZmxvYWQuDQo+
DQo+IFRoaXMgcHJvdmVzIHRoYXQgYWx0aG91Z2ggdGhlIGN4Z2JlIFBNRCByZXBvcnRzIHN1cHBv
cnQgZm9yDQo+IFJURV9FVEhfVFhfT0ZGTE9BRF9JUFY0X0NLU1VNLCBpdCAqZG9lcyBub3QgYWN0
dWFsbHkgcGVyZm9ybSBJUCBjaGVja3N1bQ0KPiBvZmZsb2FkaW5nKiBpbiBwcmFjdGljZS4NCj4N
Cj4gRm9yIGNvbnRyYXN0LCB3ZSBtdXN0IGVtcGhhc2l6ZSB0aGF0IGJvdGggb2YgdGhlIGNvcmUg
ZnVuY3Rpb25hbGl0aWVzDQo+IHdlJ3ZlIGRlc2NyaWJlZOKAlHplcm8tY29weSAobXVsdGktc2Vn
bWVudCBtYnVmKSB0cmFuc21pc3Npb24gYW5kIGZ1bGwNCj4gKElQK1VEUCkgaGFyZHdhcmUgY2hl
Y2tzdW0gb2ZmbG9hZGluZ+KAlHdvcmsgcGVyZmVjdGx5IG9uIHRoZSBzYW1lIHRlc3RiZWQNCj4g
d2hlbiB1c2luZyBOSUNzIGZyb20gSW50ZWwgKGlnYy9pNDBlKSBhbmQgb25ib2FyZCBSZWFsdGVr
KFJUTDgxMjUpDQo+IGNvbnRyb2xsZXJzLiBUaGlzIHN0cm9uZ2x5IHN1Z2dlc3RzIHRoYXQgdGhl
IGlzc3VlcyBhcmUgc3BlY2lmaWMgdG8gdGhlDQo+IENoZWxzaW8gY3hnYmUgUE1ELg0KPg0KPiAq
T3VyIERpbGVtbWEqDQo+DQo+IFRoZXNlIHR3byBpc3N1ZXMgbGVhdmUgdXMgaW4gYW4gdW50ZW5h
YmxlIHBvc2l0aW9uOg0KPg0KPiAgICAtDQo+DQo+ICAgIFRoZSBpZGVhbCAqemVyby1jb3B5IHBh
dGggaXMgY29tcGxldGVseSBicm9rZW4qLCBwcmV2ZW50aW5nIHVzIGZyb20NCj4gICAgcmVhbGl6
aW5nIGEgcHJpbWFyeSBwZXJmb3JtYW5jZSBiZW5lZml0IG9mIERQREsuDQo+ICAgIC0NCj4NCj4g
ICAgVGhlIGZhbGxiYWNrICpzaW5nbGUtY29weSBwYXRoIGlzIGhpZ2hseSBpbmVmZmljaWVudCos
IGFzIGl0IG5vdCBvbmx5DQo+ICAgIGluY3VycyB0aGUgQ1BVIGNvc3Qgb2YgYSBtZW1jcHkgYnV0
IGFsc28gcmVxdWlyZXMgdGhlIGFkZGl0aW9uYWwgQ1BVDQo+ICAgIG92ZXJoZWFkIG9mIHNvZnR3
YXJlIElQIGNoZWNrc3VtIGNhbGN1bGF0aW9uLCBsYXJnZWx5IGRlZmVhdGluZyB0aGUgcHVycG9z
ZQ0KPiAgICBvZiBoYXJkd2FyZSBvZmZsb2Fkcy4NCj4NCj4gKk91ciBRdWVzdGlvbnMqDQo+DQo+
IFdlIHVyZ2VudGx5IG5lZWQgeW91ciBoZWxwIHRvIGNsYXJpZnkgdGhlIGZvbGxvd2luZzoNCj4N
Cj4gICAgLQ0KPiAgICAgICAtDQo+DQo+ICAgICAgIElzIHRoaXMgYmVoYXZpb3IgZnJvbSB0aGUg
Y3hnYmUgUE1EIChvZmZsb2FkaW5nIG9ubHkgVURQIGNoZWNrc3VtKQ0KPiAgICAgICBjb25zaXN0
ZW50IHdpdGggdGhlIGRlc2lnbiBleHBlY3RhdGlvbnMgZm9yIGEgUE1EIGluIERQREs/DQo+ICAg
ICAgIC0NCj4NCj4gICAgICAgRG9lcyB0aGUgRFBESyBmcmFtZXdvcmsgcHJvdmlkZSBhbnkgZGVi
dWdnaW5nIG1lY2hhbmlzbXMgdG8gdHJhY2UNCj4gICAgICAgd2h5IGFuIGV4cGxpY2l0bHkgc2V0
IG9mZmxvYWQgZmxhZyAoUlRFX01CVUZfRl9UWF9JUF9DS1NVTSkgd291bGQNCj4gICAgICAgYmUg
aWdub3JlZCBieSBhIFBNRCB3aXRob3V0IHJlcG9ydGluZyBhbiBlcnJvcj8NCj4NCj4NCj4gUmVz
b2x2aW5nIHRoZXNlIGlzc3VlcyBpcyBjcml0aWNhbCB0byB0aGUgc3VjY2VzcyBvZiBvdXIgcHJv
amVjdC4gQW55DQo+IGluZm9ybWF0aW9uIG9yIGd1aWRhbmNlIHlvdSBjYW4gcHJvdmlkZSB3b3Vs
ZCBiZSBncmVhdGx5IGFwcHJlY2lhdGVkLg0KPg0KPiAqT3VyIEVudmlyb25tZW50Kg0KPg0KPiAg
ICAtDQo+DQo+ICAgICpEUERLIFZlcnNpb246KiAyNS4wNw0KPiAgICAtDQo+DQo+ICAgICpOSUMg
TW9kZWw6KiBDaGVsc2lvIFQ1MjAtQ1INCj4gICAgLQ0KPg0KPiAgICAqT1MgJiBLZXJuZWw6KiBU
aW55Y29yZTY0IDE2LjAga2VybmVsIDYuNi42Mw0KPg0KPiBUaGFuayB5b3UgZm9yIHlvdXIgdGlt
ZSBhbmQgYXR0ZW50aW9uIHRvIHRoaXMgdXJnZW50IG1hdHRlci4gV2UgbG9vaw0KPiBmb3J3YXJk
IHRvIHlvdXIgcmVzcG9uc2UuDQo+DQo+IEJlc3QgcmVnYXJkcywNCj4NCj4NCj4NCj4NCj4gKuWw
iuaVrOeahCBEUERLIOW8gOWPkeWboumYn+WSjCBDaGVsc2lvIOaKgOacr+aUr+aMgeWboumYn++8
mioNCj4NCj4g5oKo5Lus5aW977yBDQo+DQo+IOaIkeS7rOato+WcqOW8gOWPkeS4gOS4quWvueaA
p+iDveimgeaxguaegemrmOeahOWunuaXtumfs+mikea1gemhueebru+8jOS9huebruWJjeWcqOS9
v+eUqCBDaGVsc2lvIFQ1L1Q2IOezu+WIl+e9keWNoe+8iGN4Z2JlIFBNRO+8ieaXtu+8jOmBh+WI
sOS6huS4pOS4quS4pemHjeeahOW6leWxguWKn+iDvemanOeije+8jOWvvOiHtA0KPiBEUERLIOea
hOaguOW/g+S8mOWKv+aXoOazleWPkeaMpeOAguaIkeS7rOaBs+ivt+aCqOS7rOeahOe0p+aApeaP
tOWKqeOAgg0KPg0KPiAq44CQ5qC45b+D6Zeu6aKY5LiA77ya6Zu25ou36LSd77yI5aSa5q61IG1i
dWbvvInmlbDmja7ljIXlrozlhajml6Dms5Xlj5HpgIHjgJEqDQo+DQo+IOS4uuS6huWunueOsOac
gOS9juW7tui/n++8jOaIkeS7rOmHh+eUqCBEUERLIOagh+WHhueahOmbtuaLt+i0neacuuWItu+8
mumAmui/hyBydGVfcGt0bWJ1Zl9hdHRhY2hfZXh0YnVmIOWHveaVsO+8jOWwhuWklumDqOWFseS6
q+WGheWtmO+8iA0KPiBydGVfbWVtem9uZe+8ieS4reeahOmfs+mikeaVsOaNrumZhOWKoOWIsCBt
YnVmIOWktOmDqOS5i+WQjuOAguatpOaTjeS9nOS8muWIm+W7uuS4gOS4qirlpJrmrrUgbWJ1Ziog
KG5iX3NlZ3MgPiAxKeOAgg0KPg0KPiDnhLbogIzvvIzmiJHku6zlj5HnjrAgKmN4Z2JlIOmpseWK
qOWujOWFqOaXoOazleWPkemAgei/meenjeWkmuautSBtYnVmKuOAguS4gOaXpuiwg+eUqCBydGVf
ZXRoX3R4X2J1cnN0IOWPkemAgeatpOexu+aVsOaNruWMhe+8jOaXoOiuuuaYr+WQpuW8gOWQr+eh
rOS7tuWNuOi9ve+8jOWPkemAgemDveS8muWksei0pe+8iOi/lOWbnuWAvOS4ug0KPiAwIOaIluWv
vOiHtOS4ouWMhe+8ie+8jOaVsOaNruWMheaXoOazleWHuueOsOWcqOe9kee7nOS4iuOAgmN4Z2Jl
IFBNRCDnmoTog73lipvmiqXlkYrvvIh0eF9vZmZsb2FkX2NhcGHvvInkuZ/noa7lrp4q5LiN5YyF
5ZCrKg0KPiBSVEVfRVRIX1RYX09GRkxPQURfTVVMVElfU0VHUyDmoIflv5fjgIINCj4NCj4g6L+Z
6KGo5piO77yM5a+55LqOIGN4Z2JlIOmpseWKqOiAjOiogO+8jERQREsg55qE5qCH5YeG6Zu25ou3
6LSd5py65Yi25piv5a6M5YWo5LiN5Y+v55So55qE44CCDQo+DQo+ICrjgJDmoLjlv4Ppl67popjk
uozvvJrnoazku7bmoKHpqozlkozljbjovb3lip/og73kuI3lrozmlbTjgJEqDQo+DQo+IOS4uuS6
hue7lei/h+S4iui/sOmXrumimO+8jOaIkeS7rOiiq+i/q+mHh+eUqOKAnOWNleaLt+i0neKAneea
hOWmpeWNj+aWueahiO+8muaJi+WKqCBydGVfbWVtY3B5IOaVsOaNruWIsOS4gOS4quWkp+eahOOA
gei/nue7reeahOWNleautSBtYnVmDQo+IOS4reOAguiZveeEtui/meenjeaWueW8j+WPr+S7peaI
kOWKn+WPkeWMhe+8jOS9huaIkeS7rOWPkeeOsOS6huesrOS6jOS4quS4pemHjemXrumimO+8mirn
oazku7bljbjovb3lip/og73mmK/mrovnvLrnmoQq44CCDQo+DQo+IOWFt+S9k+ihqOeOsOS4uu+8
mg0KPg0KPiAgICAxLg0KPg0KPiAgICDmiJHku6zkuLogbWJ1ZiDorr7nva7kuoblrozmlbTnmoTl
jbjovb3moIflv5fvvJptLT5vbF9mbGFncyB8PSBSVEVfTUJVRl9GX1RYX0lQVjQgfA0KPiAgICBS
VEVfTUJVRl9GX1RYX0lQX0NLU1VNIHwgUlRFX01CVUZfRl9UWF9VRFBfQ0tTVU0744CCDQo+ICAg
IDIuDQo+DQo+ICAgIOWcqOWPkeWMheWJje+8jOaIkeS7rOWwhiBJUCDlkowgVURQIOWktOmDqOS4
reeahOagoemqjOWSjOWtl+autemDvea4hembtuOAgg0KPiAgICAzLg0KPg0KPiAgICDmipPljIXl
iIbmnpDlkI7lj5HnjrDvvIzlj6rmnIkgKlVEUCDmoKHpqozlkowq6KKr56Gs5Lu25q2j56Gu6K6h
566X5bm25aGr5YWF5LqG44CC6ICMICpJUCDmoKHpqozlkowq5a2X5q615L6d54S25pivIDDvvIzl
r7zoh7Tor6XljIXlnKjnvZHnu5zkuK3ooqvop4bkuLrml6DmlYjmlbDmja7ljIXogIzooqvkuKLl
vIPjgIINCj4gICAgNC4NCj4NCj4gICAg5oiR5Lus5b+F6aG75Zyo6L2v5Lu25Lit5omL5Yqo6K6h
566XIElQIOagoemqjOWSjO+8iGlwX2gtPmhkcl9jaGVja3N1bSA9IHJ0ZV9pcHY0X2Nrc3VtKGlw
X2gpO++8ie+8jOWQjOaXtuS/neaMgQ0KPiAgICBVRFAg5qCh6aqM5ZKM5Li6IDDvvIzmiY3og73o
rqnmlbDmja7ljIXmraPnoa7lj5HpgIHlubbooqvmjqXmlLbnq6/pqozor4HjgIINCj4NCj4g6L+Z
6K+B5a6e5LqGIGN4Z2JlIFBNRCDomb3nhLblo7Dnp7DmlK/mjIEgUlRFX0VUSF9UWF9PRkZMT0FE
X0lQVjRfQ0tTVU3vvIzkvYblnKjlrp7pmYXlt6XkvZzkuK0q5bm25pyq5omn6KGMIElQDQo+IOag
oemqjOWSjOeahOehrOS7tuWNuOi9vSrjgIINCj4NCj4g5L2c5Li65a+55q+U77yM5oiR5Lus6ZyA
6KaB5by66LCD55qE5piv77ya5oiR5Lus5o+P6L+w55qE6L+Z5Lik6aG55qC45b+D5Yqf6IO94oCU
4oCU5Y2z6Zu25ou36LSd77yI5aSa5q61DQo+IG1idWbvvInlj5HpgIHlkozlrozmlbTnmoTnoazk
u7bmoKHpqozlkozljbjovb3vvIhJUCtVRFDvvInvvIzlnKjmiJHku6znmoTlkIzkuIDmtYvor5Xl
ubPlj7DkuIrvvIzkvb/nlKggSW50ZWwgKGlnYy9pNDBlKSDlkowgUmVhbHRlaw0KPiAoUlRMODEy
NSkg55qE5p2/6L29572R5Y2h5pe277yM6YO95a6M5YWo5q2j5bi45bel5L2c44CC6L+Z5L2/5oiR
5Lus56Gu5L+h77yM6Zeu6aKY5piv54m55a6a5LqOIENoZWxzaW8gY3hnYmUgUE1EIOeahOOAgg0K
Pg0KPiAq44CQ5oiR5Lus55qE5Zuw5aKD44CRKg0KPg0KPiDov5nkuKTkuKrpl67popjkvb/miJHk
u6zpmbflhaXkuobnu53looPvvJoNCj4NCj4gICAgLQ0KPg0KPiAgICAq55CG5oOz55qE6Zu25ou3
6LSd6Lev5b6E5a6M5YWo5LiN6YCaKu+8jOWvvOiHtCBEUERLIOeahOaguOW/g+aAp+iDveS8mOWK
v+aXoOazleS9k+eOsOOAgg0KPiAgICAtDQo+DQo+ICAgICrlpqXljY/nmoTljZXmi7fotJ3ot6/l
voTmlYjnjofkvY7kuIsq77yM5LiN5LuF5byV5YWl5LqGIG1lbWNweSDnmoQgQ1BVIOW8gOmUgO+8
jOi/mOW/hemhu+mineWkluaJv+aLhSBJUA0KPiAgICDmoKHpqozlkoznmoTova/ku7borqHnrpfl
vIDplIDvvIzkvb/lvpfnoazku7bljbjovb3nmoTku7flgLzlpKfmiZPmipjmiaPjgIINCj4NCj4g
KuOAkOaIkeS7rOeahOmXrumimOOAkSoNCj4NCj4g5oiR5Lus5oCl6ZyA5oKo55qE5biu5Yqp5p2l
5r6E5riF5Lul5LiL6Zeu6aKY77yaDQo+DQo+ICAgIC0NCj4gICAgICAgLQ0KPg0KPiAgICAgICBj
eGdiZSDpqbHliqjnmoTov5nnp43ooYzkuLrvvIjlj6rljbjovb0gVURQIOagoemqjOWSjO+8ieaY
r+WQpuespuWQiCBEUERLIOWvuSBQTUQg55qE6K6+6K6h6aKE5pyf77yfDQo+ICAgICAgIC0NCj4N
Cj4gICAgICAgRFBESyDmoYbmnrbmmK/lkKbmnInosIPor5XmnLrliLbvvIzlj6/ku6Xov73ouKrk
uLrkvZXkuIDkuKrmmI7noa7orr7nva7nmoTljbjovb3moIflv5fvvIhSVEVfTUJVRl9GX1RYX0lQ
X0NLU1VN77yJ5Lya6KKrIFBNRA0KPiAgICAgICDlv73nlaXkuJTkuI3miqXlkYrku7vkvZXplJkN
Cj4NCj4NCj4g6Kej5Yaz6L+Z5Lqb6Zeu6aKY5a+55LqO5oiR5Lus55qE6aG555uu6IO95ZCm5oiQ
5Yqf6Iez5YWz6YeN6KaB44CC5Lu75L2V6IO95aSf5biu5Yqp5oiR5Lus5YmN6L+b55qE5bu66K6u
5oiW5L+h5oGv77yM5oiR5Lus5bCG5LiN6IOc5oSf5r+A44CCDQo+DQo+ICrjgJDmiJHku6znmoTn
jq/looPkv6Hmga/jgJEqDQo+DQo+ICAgIC0NCj4NCj4gICAgKkRQREsg54mI5pys77yaMjUuMDcq
DQo+ICAgIC0NCj4NCj4gICAgKue9keWNoeWei+WPt++8mipDaGVsc2lvIFQ1MjAtQ1INCj4gICAg
LQ0KPg0KPiAgICAq5pON5L2c57O757uf5LiO5YaF5qC454mI5pys77yaVGlueWNvcmU2NCAxNi4w
ICBrZXJuZWwgNi42LjYzKg0KPg0KPiDmhJ/osKLmgqjnmoTml7bpl7TlkozlhbPms6jvvIzmiJHk
u6zmgKXliIflnLDmnJ/lvoXmgqjnmoTlm57lpI3vvIENCj4NCj4g5q2k6Ie077yMDQo+DQo+IOaV
rOekvO+8gQ0KPg0KPg0K
--000000000000c4b91a06407cdcca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Please put this in a bugzilla report.<div dir=3D"auto"><b=
r></div></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Oct 6, 2025, 12:00 bloodyevil &lt;<a =
href=3D"mailto:bloodyevil@163.com">bloodyevil@163.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><div style=3D"line-hei=
ght:1.7;color:rgb(0,0,0);font-size:14px;font-family:Arial"><div style=3D"ma=
rgin:0px"><p style=3D"white-space:normal;color:rgb(0,0,0);font-family:Arial=
;font-size:14px;font-style:normal;font-variant-ligatures:normal;font-varian=
t-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;word-spacing:0px;text-decoration-style:initia=
l;text-decoration-color:initial;word-break:break-word"><strong style=3D"whi=
te-space:normal;word-break:break-word"><span style=3D"white-space:normal;wo=
rd-break:break-word">Dear DPDK Development Team and Chelsio Support Team,</=
span></strong></p><p style=3D"white-space:normal;color:rgb(0,0,0);font-fami=
ly:Arial;font-size:14px;font-style:normal;font-variant-ligatures:normal;fon=
t-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:star=
t;text-indent:0px;text-transform:none;word-spacing:0px;text-decoration-styl=
e:initial;text-decoration-color:initial;word-break:break-word"><span style=
=3D"white-space:normal;word-break:break-word">We are writing to report two =
severe, fundamental issues we&#39;ve encountered while using Chelsio T5/T6 =
series NICs (with the<span>=C2=A0</span></span><code style=3D"white-space:n=
ormal;word-break:break-word"><span style=3D"white-space:normal;word-break:b=
reak-word">cxgbe</span></code><span style=3D"white-space:normal;word-break:=
break-word"><span>=C2=A0</span>PMD) in our high-performance real-time audio=
 streaming application. These problems prevent us from leveraging core DPDK=
 features and require your urgent attention.</span></p><p style=3D"white-sp=
ace:normal;color:rgb(0,0,0);font-family:Arial;font-size:14px;font-style:nor=
mal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;=
letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;=
word-spacing:0px;text-decoration-style:initial;text-decoration-color:initia=
l;word-break:break-word"><strong style=3D"white-space:normal;word-break:bre=
ak-word"><span style=3D"white-space:normal;word-break:break-word">Issue #1:=
 Complete Failure to Transmit Zero-Copy (Multi-Segment) Packets</span></str=
ong></p><p style=3D"white-space:normal;color:rgb(0,0,0);font-family:Arial;f=
ont-size:14px;font-style:normal;font-variant-ligatures:normal;font-variant-=
caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-ind=
ent:0px;text-transform:none;word-spacing:0px;text-decoration-style:initial;=
text-decoration-color:initial;word-break:break-word"><span style=3D"white-s=
pace:normal;word-break:break-word">To achieve the lowest latency, we are us=
ing the standard DPDK zero-copy mechanism: attaching an external shared mem=
ory buffer (from<span>=C2=A0</span></span><code style=3D"white-space:normal=
;word-break:break-word"><span style=3D"white-space:normal;word-break:break-=
word">rte_memzone</span></code><span style=3D"white-space:normal;word-break=
:break-word">) containing our audio payload to an mbuf header using<span>=
=C2=A0</span></span><code style=3D"white-space:normal;word-break:break-word=
"><span style=3D"white-space:normal;word-break:break-word">rte_pktmbuf_atta=
ch_extbuf</span></code><span style=3D"white-space:normal;word-break:break-w=
ord">. This correctly creates a<span>=C2=A0</span></span><strong style=3D"w=
hite-space:normal;word-break:break-word"><span style=3D"white-space:normal;=
word-break:break-word">multi-segment mbuf</span></strong><span style=3D"whi=
te-space:normal;word-break:break-word"><span>=C2=A0</span>(</span><code sty=
le=3D"white-space:normal;word-break:break-word"><span style=3D"white-space:=
normal;word-break:break-word">nb_segs &gt; 1</span></code><span style=3D"wh=
ite-space:normal;word-break:break-word">).</span></p><p style=3D"white-spac=
e:normal;color:rgb(0,0,0);font-family:Arial;font-size:14px;font-style:norma=
l;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;le=
tter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;wo=
rd-spacing:0px;text-decoration-style:initial;text-decoration-color:initial;=
word-break:break-word"><span style=3D"white-space:normal;word-break:break-w=
ord">However, we have found that the<span>=C2=A0</span></span><strong style=
=3D"white-space:normal;word-break:break-word"><code style=3D"white-space:no=
rmal;word-break:break-word"><span style=3D"white-space:normal;word-break:br=
eak-word">cxgbe</span></code><span style=3D"white-space:normal;word-break:b=
reak-word"><span>=C2=A0</span>driver is completely unable to transmit these=
 multi-segment mbufs</span></strong><span style=3D"white-space:normal;word-=
break:break-word">. Any attempt to send such a packet via<span>=C2=A0</span=
></span><code style=3D"white-space:normal;word-break:break-word"><span styl=
e=3D"white-space:normal;word-break:break-word">rte_eth_tx_burst</span></cod=
e><span style=3D"white-space:normal;word-break:break-word"><span>=C2=A0</sp=
an>fails (returns 0 or results in silent packet drops), regardless of wheth=
er hardware offloads are enabled or disabled. The<span>=C2=A0</span></span>=
<code style=3D"white-space:normal;word-break:break-word"><span style=3D"whi=
te-space:normal;word-break:break-word">cxgbe</span></code><span style=3D"wh=
ite-space:normal;word-break:break-word"><span>=C2=A0</span>PMD&#39;s capabi=
lity report (</span><code style=3D"white-space:normal;word-break:break-word=
"><span style=3D"white-space:normal;word-break:break-word">tx_offload_capa<=
/span></code><span style=3D"white-space:normal;word-break:break-word">) cor=
rectly<span>=C2=A0</span></span><strong style=3D"white-space:normal;word-br=
eak:break-word"><span style=3D"white-space:normal;word-break:break-word">do=
es not include</span></strong><span style=3D"white-space:normal;word-break:=
break-word"><span>=C2=A0</span>the<span>=C2=A0</span></span><code style=3D"=
white-space:normal;word-break:break-word"><span style=3D"white-space:normal=
;word-break:break-word">RTE_ETH_TX_OFFLOAD_MULTI_SEGS</span></code><span st=
yle=3D"white-space:normal;word-break:break-word"><span>=C2=A0</span>flag.</=
span></p><p style=3D"white-space:normal;color:rgb(0,0,0);font-family:Arial;=
font-size:14px;font-style:normal;font-variant-ligatures:normal;font-variant=
-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-in=
dent:0px;text-transform:none;word-spacing:0px;text-decoration-style:initial=
;text-decoration-color:initial;word-break:break-word"><span style=3D"white-=
space:normal;word-break:break-word">This means that for the<span>=C2=A0</sp=
an></span><code style=3D"white-space:normal;word-break:break-word"><span st=
yle=3D"white-space:normal;word-break:break-word">cxgbe</span></code><span s=
tyle=3D"white-space:normal;word-break:break-word"><span>=C2=A0</span>driver=
, the standard zero-copy path in DPDK is entirely non-functional.</span></p=
><p style=3D"white-space:normal;color:rgb(0,0,0);font-family:Arial;font-siz=
e:14px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:no=
rmal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px=
;text-transform:none;word-spacing:0px;text-decoration-style:initial;text-de=
coration-color:initial;word-break:break-word"><strong style=3D"white-space:=
normal;word-break:break-word"><span style=3D"white-space:normal;word-break:=
break-word">Issue #2: Incomplete Hardware Checksum Offload</span></strong><=
/p><p style=3D"white-space:normal;color:rgb(0,0,0);font-family:Arial;font-s=
ize:14px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:=
normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0=
px;text-transform:none;word-spacing:0px;text-decoration-style:initial;text-=
decoration-color:initial;word-break:break-word"><span style=3D"white-space:=
normal;word-break:break-word">Forced to abandon zero-copy, we implemented a=
 &quot;single-copy&quot; workaround by using<span>=C2=A0</span></span><code=
 style=3D"white-space:normal;word-break:break-word"><span style=3D"white-sp=
ace:normal;word-break:break-word">rte_memcpy</span></code><span style=3D"wh=
ite-space:normal;word-break:break-word"><span>=C2=A0</span>to create a cont=
iguous, single-segment mbuf. While this allows packets to be transmitted, w=
e discovered a second critical issue:<span>=C2=A0</span></span><strong styl=
e=3D"white-space:normal;word-break:break-word"><span style=3D"white-space:n=
ormal;word-break:break-word">the hardware checksum offload functionality is=
 incomplete</span></strong><span style=3D"white-space:normal;word-break:bre=
ak-word">.</span></p><p style=3D"white-space:normal;color:rgb(0,0,0);font-f=
amily:Arial;font-size:14px;font-style:normal;font-variant-ligatures:normal;=
font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:s=
tart;text-indent:0px;text-transform:none;word-spacing:0px;text-decoration-s=
tyle:initial;text-decoration-color:initial;word-break:break-word"><span sty=
le=3D"white-space:normal;word-break:break-word">Specifically:</span></p><ol=
 style=3D"white-space:normal;color:rgb(0,0,0);font-family:Arial;font-size:1=
4px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;word-spacing:0px;text-decoration-style:initial;text-decor=
ation-color:initial;word-break:break-word"><li style=3D"white-space:normal;=
word-break:break-word"><p style=3D"white-space:normal;word-break:break-word=
"><span style=3D"white-space:normal;word-break:break-word">We set the full =
offload flags on the mbuf:<span>=C2=A0</span></span><code style=3D"white-sp=
ace:normal;word-break:break-word"><span style=3D"white-space:normal;word-br=
eak:break-word">m-&gt;ol_flags |=3D RTE_MBUF_F_TX_IPV4 | RTE_MBUF_F_TX_IP_C=
KSUM | RTE_MBUF_F_TX_UDP_CKSUM;</span></code><span style=3D"white-space:nor=
mal;word-break:break-word">.</span></p></li><li style=3D"white-space:normal=
;word-break:break-word"><p style=3D"white-space:normal;word-break:break-wor=
d"><span style=3D"white-space:normal;word-break:break-word">We zero out bot=
h the IP and UDP checksum fields in their respective headers before transmi=
ssion.</span></p></li><li style=3D"white-space:normal;word-break:break-word=
"><p style=3D"white-space:normal;word-break:break-word"><span style=3D"whit=
e-space:normal;word-break:break-word">Packet captures reveal that only the<=
span>=C2=A0</span></span><strong style=3D"white-space:normal;word-break:bre=
ak-word"><span style=3D"white-space:normal;word-break:break-word">UDP check=
sum</span></strong><span style=3D"white-space:normal;word-break:break-word"=
><span>=C2=A0</span>is correctly calculated and filled in by the hardware. =
The<span>=C2=A0</span></span><strong style=3D"white-space:normal;word-break=
:break-word"><span style=3D"white-space:normal;word-break:break-word">IP ch=
ecksum</span></strong><span style=3D"white-space:normal;word-break:break-wo=
rd"><span>=C2=A0</span>field remains zeroed, causing the packet to be treat=
ed as invalid and dropped by the network.</span></p></li><li style=3D"white=
-space:normal;word-break:break-word"><p style=3D"white-space:normal;word-br=
eak:break-word"><span style=3D"white-space:normal;word-break:break-word">Fo=
r the packet to be transmitted successfully, we are forced to<span>=C2=A0</=
span></span><strong style=3D"white-space:normal;word-break:break-word"><spa=
n style=3D"white-space:normal;word-break:break-word">manually calculate the=
 IP checksum in software</span></strong><span style=3D"white-space:normal;w=
ord-break:break-word"><span>=C2=A0</span>(</span><code style=3D"white-space=
:normal;word-break:break-word"><span style=3D"white-space:normal;word-break=
:break-word">ip_h-&gt;hdr_checksum =3D rte_ipv4_cksum(ip_h);</span></code><=
span style=3D"white-space:normal;word-break:break-word">) while keeping the=
 UDP checksum field zeroed for hardware offload.</span></p></li></ol><p sty=
le=3D"white-space:normal;color:rgb(0,0,0);font-family:Arial;font-size:14px;=
font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;fo=
nt-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-t=
ransform:none;word-spacing:0px;text-decoration-style:initial;text-decoratio=
n-color:initial;word-break:break-word"><span style=3D"white-space:normal;wo=
rd-break:break-word">This proves that although the<span>=C2=A0</span></span=
><code style=3D"white-space:normal;word-break:break-word"><span style=3D"wh=
ite-space:normal;word-break:break-word">cxgbe</span></code><span style=3D"w=
hite-space:normal;word-break:break-word"><span>=C2=A0</span>PMD reports sup=
port for<span>=C2=A0</span></span><code style=3D"white-space:normal;word-br=
eak:break-word"><span style=3D"white-space:normal;word-break:break-word">RT=
E_ETH_TX_OFFLOAD_IPV4_CKSUM</span></code><span style=3D"white-space:normal;=
word-break:break-word">, it<span>=C2=A0</span></span><strong style=3D"white=
-space:normal;word-break:break-word"><span style=3D"white-space:normal;word=
-break:break-word">does not actually perform IP checksum offloading</span><=
/strong><span style=3D"white-space:normal;word-break:break-word"><span>=C2=
=A0</span>in practice.</span></p><p style=3D"white-space:normal;color:rgb(0=
,0,0);font-family:Arial;font-size:14px;font-style:normal;font-variant-ligat=
ures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;text-=
decoration-style:initial;text-decoration-color:initial;word-break:break-wor=
d"><span style=3D"white-space:normal;word-break:break-word">For contrast, w=
e must emphasize that both of the core functionalities we&#39;ve described=
=E2=80=94zero-copy (multi-segment mbuf) transmission and full (IP+UDP) hard=
ware checksum offloading=E2=80=94work perfectly on the same testbed when us=
ing NICs from Intel (igc/i40e) and onboard Realtek(RTL8125) controllers. Th=
is strongly suggests that the issues are specific to the Chelsio cxgbe PMD.=
</span></p><p style=3D"white-space:normal;color:rgb(0,0,0);font-family:Aria=
l;font-size:14px;font-style:normal;font-variant-ligatures:normal;font-varia=
nt-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-=
indent:0px;text-transform:none;word-spacing:0px;text-decoration-style:initi=
al;text-decoration-color:initial;word-break:break-word"><strong style=3D"wh=
ite-space:normal;word-break:break-word"><span style=3D"white-space:normal;w=
ord-break:break-word">Our Dilemma</span></strong></p><p style=3D"white-spac=
e:normal;color:rgb(0,0,0);font-family:Arial;font-size:14px;font-style:norma=
l;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;le=
tter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;wo=
rd-spacing:0px;text-decoration-style:initial;text-decoration-color:initial;=
word-break:break-word"><span style=3D"white-space:normal;word-break:break-w=
ord">These two issues leave us in an untenable position:</span></p><ul styl=
e=3D"white-space:normal;color:rgb(0,0,0);font-family:Arial;font-size:14px;f=
ont-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;fon=
t-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tr=
ansform:none;word-spacing:0px;text-decoration-style:initial;text-decoration=
-color:initial;word-break:break-word"><li style=3D"white-space:normal;word-=
break:break-word"><p style=3D"white-space:normal;word-break:break-word"><sp=
an style=3D"white-space:normal;word-break:break-word">The ideal<span>=C2=A0=
</span></span><strong style=3D"white-space:normal;word-break:break-word"><s=
pan style=3D"white-space:normal;word-break:break-word">zero-copy path is co=
mpletely broken</span></strong><span style=3D"white-space:normal;word-break=
:break-word">, preventing us from realizing a primary performance benefit o=
f DPDK.</span></p></li><li style=3D"white-space:normal;word-break:break-wor=
d"><p style=3D"white-space:normal;word-break:break-word"><span style=3D"whi=
te-space:normal;word-break:break-word">The fallback<span>=C2=A0</span></spa=
n><strong style=3D"white-space:normal;word-break:break-word"><span style=3D=
"white-space:normal;word-break:break-word">single-copy path is highly ineff=
icient</span></strong><span style=3D"white-space:normal;word-break:break-wo=
rd">, as it not only incurs the CPU cost of a<span>=C2=A0</span></span><cod=
e style=3D"white-space:normal;word-break:break-word"><span style=3D"white-s=
pace:normal;word-break:break-word">memcpy</span></code><span style=3D"white=
-space:normal;word-break:break-word"><span>=C2=A0</span>but also requires t=
he additional CPU overhead of software IP checksum calculation, largely def=
eating the purpose of hardware offloads.</span></p></li></ul><p style=3D"wh=
ite-space:normal;color:rgb(0,0,0);font-family:Arial;font-size:14px;font-sty=
le:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weigh=
t:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform=
:none;word-spacing:0px;text-decoration-style:initial;text-decoration-color:=
initial;word-break:break-word"><strong style=3D"white-space:normal;word-bre=
ak:break-word"><span style=3D"white-space:normal;word-break:break-word">Our=
 Questions</span></strong></p><p style=3D"white-space:normal;color:rgb(0,0,=
0);font-family:Arial;font-size:14px;font-style:normal;font-variant-ligature=
s:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;tex=
t-align:start;text-indent:0px;text-transform:none;word-spacing:0px;text-dec=
oration-style:initial;text-decoration-color:initial;word-break:break-word">=
<span style=3D"white-space:normal;word-break:break-word">We urgently need y=
our help to clarify the following:</span></p><ol style=3D"white-space:norma=
l;color:rgb(0,0,0);font-family:Arial;font-size:14px;font-style:normal;font-=
variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-sp=
acing:normal;text-align:start;text-indent:0px;text-transform:none;word-spac=
ing:0px;text-decoration-style:initial;text-decoration-color:initial;word-br=
eak:break-word"><ul style=3D"white-space:normal;word-break:break-word"><li =
style=3D"white-space:normal;word-break:break-word"></li><li><p><span>Is thi=
s behavior from the </span><code><span>cxgbe</span></code><span> PMD (offlo=
ading only UDP checksum) consistent with the design expectations for a PMD =
in DPDK?</span></p></li><li><p><span>Does the DPDK framework provide any de=
bugging mechanisms to trace why an explicitly set offload flag (</span><cod=
e><span>RTE_MBUF_F_TX_IP_CKSUM</span></code><span>) would be ignored by a P=
MD without reporting an error?</span></p></li></ul></ol><span style=3D"whit=
e-space:normal;color:rgb(0,0,0);font-family:Arial;font-size:14px;font-style=
:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:=
400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:n=
one;word-spacing:0px;text-decoration-style:initial;text-decoration-color:in=
itial;word-break:break-word"><br style=3D"white-space:normal;word-break:bre=
ak-word"><p style=3D"white-space:normal;word-break:break-word"><span style=
=3D"white-space:normal;word-break:break-word">Resolving these issues is cri=
tical to the success of our project. Any information or guidance you can pr=
ovide would be greatly appreciated.</span></p><p style=3D"white-space:norma=
l;word-break:break-word"><strong style=3D"white-space:normal;word-break:bre=
ak-word"><span style=3D"white-space:normal;word-break:break-word">Our Envir=
onment</span></strong></p><ul style=3D"white-space:normal;word-break:break-=
word"><li style=3D"white-space:normal;word-break:break-word"><p style=3D"wh=
ite-space:normal;word-break:break-word"><strong style=3D"white-space:normal=
;word-break:break-word"><span style=3D"white-space:normal;word-break:break-=
word">DPDK Version:</span></strong><span style=3D"white-space:normal;word-b=
reak:break-word">=C2=A025.07</span></p></li><li style=3D"white-space:normal=
;word-break:break-word"><p style=3D"white-space:normal;word-break:break-wor=
d"><strong style=3D"white-space:normal;word-break:break-word"><span style=
=3D"white-space:normal;word-break:break-word">NIC Model:</span></strong><sp=
an style=3D"white-space:normal;word-break:break-word"><span>=C2=A0</span></=
span><code style=3D"white-space:normal;word-break:break-word"><span style=
=3D"white-space:normal;word-break:break-word">Chelsio T520-CR</span></code>=
</p></li><li style=3D"white-space:normal;word-break:break-word"><p style=3D=
"white-space:normal;word-break:break-word"><strong style=3D"white-space:nor=
mal;word-break:break-word"><span style=3D"white-space:normal;word-break:bre=
ak-word">OS &amp; Kernel:</span></strong><span style=3D"white-space:normal;=
word-break:break-word">=C2=A0<font face=3D"monospace" style=3D"white-space:=
normal;word-break:break-word">Tinycore64 16.0 kernel 6.6.63</font></span></=
p></li></ul><p style=3D"white-space:normal;word-break:break-word"><span sty=
le=3D"white-space:normal;word-break:break-word">Thank you for your time and=
 attention to this urgent matter. We look forward to your response.</span><=
/p><p style=3D"white-space:normal;word-break:break-word"><span style=3D"whi=
te-space:normal;word-break:break-word">Best regards,</span></p><p style=3D"=
white-space:normal;word-break:break-word"><span style=3D"white-space:normal=
;word-break:break-word"><br style=3D"white-space:normal;word-break:break-wo=
rd"><br style=3D"white-space:normal;word-break:break-word"><br style=3D"whi=
te-space:normal;word-break:break-word"></span></p><p style=3D"white-space:n=
ormal;word-break:break-word"><strong style=3D"white-space:normal;word-break=
:break-word"><span style=3D"white-space:normal;word-break:break-word">=E5=
=B0=8A=E6=95=AC=E7=9A=84 DPDK =E5=BC=80=E5=8F=91=E5=9B=A2=E9=98=9F=E5=92=8C=
 Chelsio =E6=8A=80=E6=9C=AF=E6=94=AF=E6=8C=81=E5=9B=A2=E9=98=9F=EF=BC=9A</s=
pan></strong></p><p style=3D"white-space:normal;word-break:break-word"><spa=
n style=3D"white-space:normal;word-break:break-word">=E6=82=A8=E4=BB=AC=E5=
=A5=BD=EF=BC=81</span></p><p style=3D"white-space:normal;word-break:break-w=
ord"><span style=3D"white-space:normal;word-break:break-word">=E6=88=91=E4=
=BB=AC=E6=AD=A3=E5=9C=A8=E5=BC=80=E5=8F=91=E4=B8=80=E4=B8=AA=E5=AF=B9=E6=80=
=A7=E8=83=BD=E8=A6=81=E6=B1=82=E6=9E=81=E9=AB=98=E7=9A=84=E5=AE=9E=E6=97=B6=
=E9=9F=B3=E9=A2=91=E6=B5=81=E9=A1=B9=E7=9B=AE=EF=BC=8C=E4=BD=86=E7=9B=AE=E5=
=89=8D=E5=9C=A8=E4=BD=BF=E7=94=A8 Chelsio T5/T6 =E7=B3=BB=E5=88=97=E7=BD=91=
=E5=8D=A1=EF=BC=88</span><code style=3D"white-space:normal;word-break:break=
-word"><span style=3D"white-space:normal;word-break:break-word">cxgbe</span=
></code><span style=3D"white-space:normal;word-break:break-word"><span>=C2=
=A0</span>PMD=EF=BC=89=E6=97=B6=EF=BC=8C=E9=81=87=E5=88=B0=E4=BA=86=E4=B8=
=A4=E4=B8=AA=E4=B8=A5=E9=87=8D=E7=9A=84=E5=BA=95=E5=B1=82=E5=8A=9F=E8=83=BD=
=E9=9A=9C=E7=A2=8D=EF=BC=8C=E5=AF=BC=E8=87=B4 DPDK =E7=9A=84=E6=A0=B8=E5=BF=
=83=E4=BC=98=E5=8A=BF=E6=97=A0=E6=B3=95=E5=8F=91=E6=8C=A5=E3=80=82=E6=88=91=
=E4=BB=AC=E6=81=B3=E8=AF=B7=E6=82=A8=E4=BB=AC=E7=9A=84=E7=B4=A7=E6=80=A5=E6=
=8F=B4=E5=8A=A9=E3=80=82</span></p><p style=3D"white-space:normal;word-brea=
k:break-word"><strong style=3D"white-space:normal;word-break:break-word"><s=
pan style=3D"white-space:normal;word-break:break-word">=E3=80=90=E6=A0=B8=
=E5=BF=83=E9=97=AE=E9=A2=98=E4=B8=80=EF=BC=9A=E9=9B=B6=E6=8B=B7=E8=B4=9D=EF=
=BC=88=E5=A4=9A=E6=AE=B5 mbuf=EF=BC=89=E6=95=B0=E6=8D=AE=E5=8C=85=E5=AE=8C=
=E5=85=A8=E6=97=A0=E6=B3=95=E5=8F=91=E9=80=81=E3=80=91</span></strong></p><=
p style=3D"white-space:normal;word-break:break-word"><span style=3D"white-s=
pace:normal;word-break:break-word">=E4=B8=BA=E4=BA=86=E5=AE=9E=E7=8E=B0=E6=
=9C=80=E4=BD=8E=E5=BB=B6=E8=BF=9F=EF=BC=8C=E6=88=91=E4=BB=AC=E9=87=87=E7=94=
=A8 DPDK =E6=A0=87=E5=87=86=E7=9A=84=E9=9B=B6=E6=8B=B7=E8=B4=9D=E6=9C=BA=E5=
=88=B6=EF=BC=9A=E9=80=9A=E8=BF=87<span>=C2=A0</span></span><code style=3D"w=
hite-space:normal;word-break:break-word"><span style=3D"white-space:normal;=
word-break:break-word">rte_pktmbuf_attach_extbuf</span></code><span style=
=3D"white-space:normal;word-break:break-word"><span>=C2=A0</span>=E5=87=BD=
=E6=95=B0=EF=BC=8C=E5=B0=86=E5=A4=96=E9=83=A8=E5=85=B1=E4=BA=AB=E5=86=85=E5=
=AD=98=EF=BC=88</span><code style=3D"white-space:normal;word-break:break-wo=
rd"><span style=3D"white-space:normal;word-break:break-word">rte_memzone</s=
pan></code><span style=3D"white-space:normal;word-break:break-word">=EF=BC=
=89=E4=B8=AD=E7=9A=84=E9=9F=B3=E9=A2=91=E6=95=B0=E6=8D=AE=E9=99=84=E5=8A=A0=
=E5=88=B0 mbuf =E5=A4=B4=E9=83=A8=E4=B9=8B=E5=90=8E=E3=80=82=E6=AD=A4=E6=93=
=8D=E4=BD=9C=E4=BC=9A=E5=88=9B=E5=BB=BA=E4=B8=80=E4=B8=AA</span><strong sty=
le=3D"white-space:normal;word-break:break-word"><span style=3D"white-space:=
normal;word-break:break-word">=E5=A4=9A=E6=AE=B5 mbuf</span></strong><span =
style=3D"white-space:normal;word-break:break-word"><span>=C2=A0</span>(</sp=
an><code style=3D"white-space:normal;word-break:break-word"><span style=3D"=
white-space:normal;word-break:break-word">nb_segs &gt; 1</span></code><span=
 style=3D"white-space:normal;word-break:break-word">)=E3=80=82</span></p><p=
 style=3D"white-space:normal;word-break:break-word"><span style=3D"white-sp=
ace:normal;word-break:break-word">=E7=84=B6=E8=80=8C=EF=BC=8C=E6=88=91=E4=
=BB=AC=E5=8F=91=E7=8E=B0<span>=C2=A0</span></span><strong style=3D"white-sp=
ace:normal;word-break:break-word"><code style=3D"white-space:normal;word-br=
eak:break-word"><span style=3D"white-space:normal;word-break:break-word">cx=
gbe</span></code><span style=3D"white-space:normal;word-break:break-word"><=
span>=C2=A0</span>=E9=A9=B1=E5=8A=A8=E5=AE=8C=E5=85=A8=E6=97=A0=E6=B3=95=E5=
=8F=91=E9=80=81=E8=BF=99=E7=A7=8D=E5=A4=9A=E6=AE=B5 mbuf</span></strong><sp=
an style=3D"white-space:normal;word-break:break-word">=E3=80=82=E4=B8=80=E6=
=97=A6=E8=B0=83=E7=94=A8<span>=C2=A0</span></span><code style=3D"white-spac=
e:normal;word-break:break-word"><span style=3D"white-space:normal;word-brea=
k:break-word">rte_eth_tx_burst</span></code><span style=3D"white-space:norm=
al;word-break:break-word"><span>=C2=A0</span>=E5=8F=91=E9=80=81=E6=AD=A4=E7=
=B1=BB=E6=95=B0=E6=8D=AE=E5=8C=85=EF=BC=8C=E6=97=A0=E8=AE=BA=E6=98=AF=E5=90=
=A6=E5=BC=80=E5=90=AF=E7=A1=AC=E4=BB=B6=E5=8D=B8=E8=BD=BD=EF=BC=8C=E5=8F=91=
=E9=80=81=E9=83=BD=E4=BC=9A=E5=A4=B1=E8=B4=A5=EF=BC=88=E8=BF=94=E5=9B=9E=E5=
=80=BC=E4=B8=BA 0 =E6=88=96=E5=AF=BC=E8=87=B4=E4=B8=A2=E5=8C=85=EF=BC=89=EF=
=BC=8C=E6=95=B0=E6=8D=AE=E5=8C=85=E6=97=A0=E6=B3=95=E5=87=BA=E7=8E=B0=E5=9C=
=A8=E7=BD=91=E7=BB=9C=E4=B8=8A=E3=80=82</span><code style=3D"white-space:no=
rmal;word-break:break-word"><span style=3D"white-space:normal;word-break:br=
eak-word">cxgbe</span></code><span style=3D"white-space:normal;word-break:b=
reak-word"><span>=C2=A0</span>PMD =E7=9A=84=E8=83=BD=E5=8A=9B=E6=8A=A5=E5=
=91=8A=EF=BC=88</span><code style=3D"white-space:normal;word-break:break-wo=
rd"><span style=3D"white-space:normal;word-break:break-word">tx_offload_cap=
a</span></code><span style=3D"white-space:normal;word-break:break-word">=EF=
=BC=89=E4=B9=9F=E7=A1=AE=E5=AE=9E</span><strong style=3D"white-space:normal=
;word-break:break-word"><span style=3D"white-space:normal;word-break:break-=
word">=E4=B8=8D=E5=8C=85=E5=90=AB</span></strong><span style=3D"white-space=
:normal;word-break:break-word"><span>=C2=A0</span></span><code style=3D"whi=
te-space:normal;word-break:break-word"><span style=3D"white-space:normal;wo=
rd-break:break-word">RTE_ETH_TX_OFFLOAD_MULTI_SEGS</span></code><span style=
=3D"white-space:normal;word-break:break-word"><span>=C2=A0</span>=E6=A0=87=
=E5=BF=97=E3=80=82</span></p><p style=3D"white-space:normal;word-break:brea=
k-word"><span style=3D"white-space:normal;word-break:break-word">=E8=BF=99=
=E8=A1=A8=E6=98=8E=EF=BC=8C=E5=AF=B9=E4=BA=8E<span>=C2=A0</span></span><cod=
e style=3D"white-space:normal;word-break:break-word"><span style=3D"white-s=
pace:normal;word-break:break-word">cxgbe</span></code><span style=3D"white-=
space:normal;word-break:break-word"><span>=C2=A0</span>=E9=A9=B1=E5=8A=A8=
=E8=80=8C=E8=A8=80=EF=BC=8CDPDK =E7=9A=84=E6=A0=87=E5=87=86=E9=9B=B6=E6=8B=
=B7=E8=B4=9D=E6=9C=BA=E5=88=B6=E6=98=AF=E5=AE=8C=E5=85=A8=E4=B8=8D=E5=8F=AF=
=E7=94=A8=E7=9A=84=E3=80=82</span></p><p style=3D"white-space:normal;word-b=
reak:break-word"><strong style=3D"white-space:normal;word-break:break-word"=
><span style=3D"white-space:normal;word-break:break-word">=E3=80=90=E6=A0=
=B8=E5=BF=83=E9=97=AE=E9=A2=98=E4=BA=8C=EF=BC=9A=E7=A1=AC=E4=BB=B6=E6=A0=A1=
=E9=AA=8C=E5=92=8C=E5=8D=B8=E8=BD=BD=E5=8A=9F=E8=83=BD=E4=B8=8D=E5=AE=8C=E6=
=95=B4=E3=80=91</span></strong></p><p style=3D"white-space:normal;word-brea=
k:break-word"><span style=3D"white-space:normal;word-break:break-word">=E4=
=B8=BA=E4=BA=86=E7=BB=95=E8=BF=87=E4=B8=8A=E8=BF=B0=E9=97=AE=E9=A2=98=EF=BC=
=8C=E6=88=91=E4=BB=AC=E8=A2=AB=E8=BF=AB=E9=87=87=E7=94=A8=E2=80=9C=E5=8D=95=
=E6=8B=B7=E8=B4=9D=E2=80=9D=E7=9A=84=E5=A6=A5=E5=8D=8F=E6=96=B9=E6=A1=88=EF=
=BC=9A=E6=89=8B=E5=8A=A8<span>=C2=A0</span></span><code style=3D"white-spac=
e:normal;word-break:break-word"><span style=3D"white-space:normal;word-brea=
k:break-word">rte_memcpy</span></code><span style=3D"white-space:normal;wor=
d-break:break-word"><span>=C2=A0</span>=E6=95=B0=E6=8D=AE=E5=88=B0=E4=B8=80=
=E4=B8=AA=E5=A4=A7=E7=9A=84=E3=80=81=E8=BF=9E=E7=BB=AD=E7=9A=84=E5=8D=95=E6=
=AE=B5 mbuf =E4=B8=AD=E3=80=82=E8=99=BD=E7=84=B6=E8=BF=99=E7=A7=8D=E6=96=B9=
=E5=BC=8F=E5=8F=AF=E4=BB=A5=E6=88=90=E5=8A=9F=E5=8F=91=E5=8C=85=EF=BC=8C=E4=
=BD=86=E6=88=91=E4=BB=AC=E5=8F=91=E7=8E=B0=E4=BA=86=E7=AC=AC=E4=BA=8C=E4=B8=
=AA=E4=B8=A5=E9=87=8D=E9=97=AE=E9=A2=98=EF=BC=9A</span><strong style=3D"whi=
te-space:normal;word-break:break-word"><span style=3D"white-space:normal;wo=
rd-break:break-word">=E7=A1=AC=E4=BB=B6=E5=8D=B8=E8=BD=BD=E5=8A=9F=E8=83=BD=
=E6=98=AF=E6=AE=8B=E7=BC=BA=E7=9A=84</span></strong><span style=3D"white-sp=
ace:normal;word-break:break-word">=E3=80=82</span></p><p style=3D"white-spa=
ce:normal;word-break:break-word"><span style=3D"white-space:normal;word-bre=
ak:break-word">=E5=85=B7=E4=BD=93=E8=A1=A8=E7=8E=B0=E4=B8=BA=EF=BC=9A</span=
></p><ol style=3D"white-space:normal;word-break:break-word"><li style=3D"wh=
ite-space:normal;word-break:break-word"><p style=3D"white-space:normal;word=
-break:break-word"><span style=3D"white-space:normal;word-break:break-word"=
>=E6=88=91=E4=BB=AC=E4=B8=BA mbuf =E8=AE=BE=E7=BD=AE=E4=BA=86=E5=AE=8C=E6=
=95=B4=E7=9A=84=E5=8D=B8=E8=BD=BD=E6=A0=87=E5=BF=97=EF=BC=9A</span><code st=
yle=3D"white-space:normal;word-break:break-word"><span style=3D"white-space=
:normal;word-break:break-word">m-&gt;ol_flags |=3D RTE_MBUF_F_TX_IPV4 | RTE=
_MBUF_F_TX_IP_CKSUM | RTE_MBUF_F_TX_UDP_CKSUM;</span></code><span style=3D"=
white-space:normal;word-break:break-word">=E3=80=82</span></p></li><li styl=
e=3D"white-space:normal;word-break:break-word"><p style=3D"white-space:norm=
al;word-break:break-word"><span style=3D"white-space:normal;word-break:brea=
k-word">=E5=9C=A8=E5=8F=91=E5=8C=85=E5=89=8D=EF=BC=8C=E6=88=91=E4=BB=AC=E5=
=B0=86 IP =E5=92=8C UDP =E5=A4=B4=E9=83=A8=E4=B8=AD=E7=9A=84=E6=A0=A1=E9=AA=
=8C=E5=92=8C=E5=AD=97=E6=AE=B5=E9=83=BD=E6=B8=85=E9=9B=B6=E3=80=82</span></=
p></li><li style=3D"white-space:normal;word-break:break-word"><p style=3D"w=
hite-space:normal;word-break:break-word"><span style=3D"white-space:normal;=
word-break:break-word">=E6=8A=93=E5=8C=85=E5=88=86=E6=9E=90=E5=90=8E=E5=8F=
=91=E7=8E=B0=EF=BC=8C=E5=8F=AA=E6=9C=89<span>=C2=A0</span></span><strong st=
yle=3D"white-space:normal;word-break:break-word"><span style=3D"white-space=
:normal;word-break:break-word">UDP =E6=A0=A1=E9=AA=8C=E5=92=8C</span></stro=
ng><span style=3D"white-space:normal;word-break:break-word">=E8=A2=AB=E7=A1=
=AC=E4=BB=B6=E6=AD=A3=E7=A1=AE=E8=AE=A1=E7=AE=97=E5=B9=B6=E5=A1=AB=E5=85=85=
=E4=BA=86=E3=80=82=E8=80=8C<span>=C2=A0</span></span><strong style=3D"white=
-space:normal;word-break:break-word"><span style=3D"white-space:normal;word=
-break:break-word">IP =E6=A0=A1=E9=AA=8C=E5=92=8C</span></strong><span styl=
e=3D"white-space:normal;word-break:break-word">=E5=AD=97=E6=AE=B5=E4=BE=9D=
=E7=84=B6=E6=98=AF 0=EF=BC=8C=E5=AF=BC=E8=87=B4=E8=AF=A5=E5=8C=85=E5=9C=A8=
=E7=BD=91=E7=BB=9C=E4=B8=AD=E8=A2=AB=E8=A7=86=E4=B8=BA=E6=97=A0=E6=95=88=E6=
=95=B0=E6=8D=AE=E5=8C=85=E8=80=8C=E8=A2=AB=E4=B8=A2=E5=BC=83=E3=80=82</span=
></p></li><li style=3D"white-space:normal;word-break:break-word"><p style=
=3D"white-space:normal;word-break:break-word"><span style=3D"white-space:no=
rmal;word-break:break-word">=E6=88=91=E4=BB=AC=E5=BF=85=E9=A1=BB=E5=9C=A8=
=E8=BD=AF=E4=BB=B6=E4=B8=AD=E6=89=8B=E5=8A=A8=E8=AE=A1=E7=AE=97 IP =E6=A0=
=A1=E9=AA=8C=E5=92=8C=EF=BC=88</span><code style=3D"white-space:normal;word=
-break:break-word"><span style=3D"white-space:normal;word-break:break-word"=
>ip_h-&gt;hdr_checksum =3D rte_ipv4_cksum(ip_h);</span></code><span style=
=3D"white-space:normal;word-break:break-word">=EF=BC=89=EF=BC=8C=E5=90=8C=
=E6=97=B6=E4=BF=9D=E6=8C=81 UDP =E6=A0=A1=E9=AA=8C=E5=92=8C=E4=B8=BA 0=EF=
=BC=8C=E6=89=8D=E8=83=BD=E8=AE=A9=E6=95=B0=E6=8D=AE=E5=8C=85=E6=AD=A3=E7=A1=
=AE=E5=8F=91=E9=80=81=E5=B9=B6=E8=A2=AB=E6=8E=A5=E6=94=B6=E7=AB=AF=E9=AA=8C=
=E8=AF=81=E3=80=82</span></p></li></ol><p style=3D"white-space:normal;word-=
break:break-word"><span style=3D"white-space:normal;word-break:break-word">=
=E8=BF=99=E8=AF=81=E5=AE=9E=E4=BA=86<span>=C2=A0</span></span><code style=
=3D"white-space:normal;word-break:break-word"><span style=3D"white-space:no=
rmal;word-break:break-word">cxgbe</span></code><span style=3D"white-space:n=
ormal;word-break:break-word"><span>=C2=A0</span>PMD =E8=99=BD=E7=84=B6=E5=
=A3=B0=E7=A7=B0=E6=94=AF=E6=8C=81<span>=C2=A0</span></span><code style=3D"w=
hite-space:normal;word-break:break-word"><span style=3D"white-space:normal;=
word-break:break-word">RTE_ETH_TX_OFFLOAD_IPV4_CKSUM</span></code><span sty=
le=3D"white-space:normal;word-break:break-word">=EF=BC=8C=E4=BD=86=E5=9C=A8=
=E5=AE=9E=E9=99=85=E5=B7=A5=E4=BD=9C=E4=B8=AD</span><strong style=3D"white-=
space:normal;word-break:break-word"><span style=3D"white-space:normal;word-=
break:break-word">=E5=B9=B6=E6=9C=AA=E6=89=A7=E8=A1=8C IP =E6=A0=A1=E9=AA=
=8C=E5=92=8C=E7=9A=84=E7=A1=AC=E4=BB=B6=E5=8D=B8=E8=BD=BD</span></strong><s=
pan style=3D"white-space:normal;word-break:break-word">=E3=80=82</span></p>=
<p style=3D"white-space:normal;word-break:break-word"><span style=3D"white-=
space:normal;word-break:break-word">=E4=BD=9C=E4=B8=BA=E5=AF=B9=E6=AF=94=EF=
=BC=8C=E6=88=91=E4=BB=AC=E9=9C=80=E8=A6=81=E5=BC=BA=E8=B0=83=E7=9A=84=E6=98=
=AF=EF=BC=9A=E6=88=91=E4=BB=AC=E6=8F=8F=E8=BF=B0=E7=9A=84=E8=BF=99=E4=B8=A4=
=E9=A1=B9=E6=A0=B8=E5=BF=83=E5=8A=9F=E8=83=BD=E2=80=94=E2=80=94=E5=8D=B3=E9=
=9B=B6=E6=8B=B7=E8=B4=9D=EF=BC=88=E5=A4=9A=E6=AE=B5 mbuf=EF=BC=89=E5=8F=91=
=E9=80=81=E5=92=8C=E5=AE=8C=E6=95=B4=E7=9A=84=E7=A1=AC=E4=BB=B6=E6=A0=A1=E9=
=AA=8C=E5=92=8C=E5=8D=B8=E8=BD=BD=EF=BC=88IP+UDP=EF=BC=89=EF=BC=8C=E5=9C=A8=
=E6=88=91=E4=BB=AC=E7=9A=84=E5=90=8C=E4=B8=80=E6=B5=8B=E8=AF=95=E5=B9=B3=E5=
=8F=B0=E4=B8=8A=EF=BC=8C=E4=BD=BF=E7=94=A8 Intel (igc/i40e) =E5=92=8C Realt=
ek (RTL8125) =E7=9A=84=E6=9D=BF=E8=BD=BD=E7=BD=91=E5=8D=A1=E6=97=B6=EF=BC=
=8C=E9=83=BD=E5=AE=8C=E5=85=A8=E6=AD=A3=E5=B8=B8=E5=B7=A5=E4=BD=9C=E3=80=82=
=E8=BF=99=E4=BD=BF=E6=88=91=E4=BB=AC=E7=A1=AE=E4=BF=A1=EF=BC=8C=E9=97=AE=E9=
=A2=98=E6=98=AF=E7=89=B9=E5=AE=9A=E4=BA=8E Chelsio cxgbe PMD =E7=9A=84=E3=
=80=82</span></p><p style=3D"white-space:normal;word-break:break-word"><str=
ong style=3D"white-space:normal;word-break:break-word"><span style=3D"white=
-space:normal;word-break:break-word">=E3=80=90=E6=88=91=E4=BB=AC=E7=9A=84=
=E5=9B=B0=E5=A2=83=E3=80=91</span></strong></p><p style=3D"white-space:norm=
al;word-break:break-word"><span style=3D"white-space:normal;word-break:brea=
k-word">=E8=BF=99=E4=B8=A4=E4=B8=AA=E9=97=AE=E9=A2=98=E4=BD=BF=E6=88=91=E4=
=BB=AC=E9=99=B7=E5=85=A5=E4=BA=86=E7=BB=9D=E5=A2=83=EF=BC=9A</span></p><ul =
style=3D"white-space:normal;word-break:break-word"><li style=3D"white-space=
:normal;word-break:break-word"><p style=3D"white-space:normal;word-break:br=
eak-word"><strong style=3D"white-space:normal;word-break:break-word"><span =
style=3D"white-space:normal;word-break:break-word">=E7=90=86=E6=83=B3=E7=9A=
=84=E9=9B=B6=E6=8B=B7=E8=B4=9D=E8=B7=AF=E5=BE=84=E5=AE=8C=E5=85=A8=E4=B8=8D=
=E9=80=9A</span></strong><span style=3D"white-space:normal;word-break:break=
-word">=EF=BC=8C=E5=AF=BC=E8=87=B4 DPDK =E7=9A=84=E6=A0=B8=E5=BF=83=E6=80=
=A7=E8=83=BD=E4=BC=98=E5=8A=BF=E6=97=A0=E6=B3=95=E4=BD=93=E7=8E=B0=E3=80=82=
</span></p></li><li style=3D"white-space:normal;word-break:break-word"><p s=
tyle=3D"white-space:normal;word-break:break-word"><strong style=3D"white-sp=
ace:normal;word-break:break-word"><span style=3D"white-space:normal;word-br=
eak:break-word">=E5=A6=A5=E5=8D=8F=E7=9A=84=E5=8D=95=E6=8B=B7=E8=B4=9D=E8=
=B7=AF=E5=BE=84=E6=95=88=E7=8E=87=E4=BD=8E=E4=B8=8B</span></strong><span st=
yle=3D"white-space:normal;word-break:break-word">=EF=BC=8C=E4=B8=8D=E4=BB=
=85=E5=BC=95=E5=85=A5=E4=BA=86<span>=C2=A0</span></span><code style=3D"whit=
e-space:normal;word-break:break-word"><span style=3D"white-space:normal;wor=
d-break:break-word">memcpy</span></code><span style=3D"white-space:normal;w=
ord-break:break-word"><span>=C2=A0</span>=E7=9A=84 CPU =E5=BC=80=E9=94=80=
=EF=BC=8C=E8=BF=98=E5=BF=85=E9=A1=BB=E9=A2=9D=E5=A4=96=E6=89=BF=E6=8B=85 IP=
 =E6=A0=A1=E9=AA=8C=E5=92=8C=E7=9A=84=E8=BD=AF=E4=BB=B6=E8=AE=A1=E7=AE=97=
=E5=BC=80=E9=94=80=EF=BC=8C=E4=BD=BF=E5=BE=97=E7=A1=AC=E4=BB=B6=E5=8D=B8=E8=
=BD=BD=E7=9A=84=E4=BB=B7=E5=80=BC=E5=A4=A7=E6=89=93=E6=8A=98=E6=89=A3=E3=80=
=82</span></p></li></ul><p style=3D"white-space:normal;word-break:break-wor=
d"><strong style=3D"white-space:normal;word-break:break-word"><span style=
=3D"white-space:normal;word-break:break-word">=E3=80=90=E6=88=91=E4=BB=AC=
=E7=9A=84=E9=97=AE=E9=A2=98=E3=80=91</span></strong></p><p style=3D"white-s=
pace:normal;word-break:break-word"><span style=3D"white-space:normal;word-b=
reak:break-word">=E6=88=91=E4=BB=AC=E6=80=A5=E9=9C=80=E6=82=A8=E7=9A=84=E5=
=B8=AE=E5=8A=A9=E6=9D=A5=E6=BE=84=E6=B8=85=E4=BB=A5=E4=B8=8B=E9=97=AE=E9=A2=
=98=EF=BC=9A</span></p><ol style=3D"white-space:normal;word-break:break-wor=
d"><ul style=3D"white-space:normal;word-break:break-word"><li style=3D"whit=
e-space:normal;word-break:break-word"></li><li><p><code><span>cxgbe</span><=
/code><span> =E9=A9=B1=E5=8A=A8=E7=9A=84=E8=BF=99=E7=A7=8D=E8=A1=8C=E4=B8=
=BA=EF=BC=88=E5=8F=AA=E5=8D=B8=E8=BD=BD UDP =E6=A0=A1=E9=AA=8C=E5=92=8C=EF=
=BC=89=E6=98=AF=E5=90=A6=E7=AC=A6=E5=90=88 DPDK =E5=AF=B9 PMD =E7=9A=84=E8=
=AE=BE=E8=AE=A1=E9=A2=84=E6=9C=9F=EF=BC=9F</span></p></li><li><p><span>DPDK=
 =E6=A1=86=E6=9E=B6=E6=98=AF=E5=90=A6=E6=9C=89=E8=B0=83=E8=AF=95=E6=9C=BA=
=E5=88=B6=EF=BC=8C=E5=8F=AF=E4=BB=A5=E8=BF=BD=E8=B8=AA=E4=B8=BA=E4=BD=95=E4=
=B8=80=E4=B8=AA=E6=98=8E=E7=A1=AE=E8=AE=BE=E7=BD=AE=E7=9A=84=E5=8D=B8=E8=BD=
=BD=E6=A0=87=E5=BF=97=EF=BC=88</span><code><span>RTE_MBUF_F_TX_IP_CKSUM</sp=
an></code><span>=EF=BC=89=E4=BC=9A=E8=A2=AB PMD =E5=BF=BD=E7=95=A5=E4=B8=94=
=E4=B8=8D=E6=8A=A5=E5=91=8A=E4=BB=BB=E4=BD=95=E9=94=99</span></p></li></ul>=
</ol><b style=3D"white-space:normal;word-break:break-word"><br style=3D"whi=
te-space:normal;word-break:break-word"></b><p style=3D"white-space:normal;w=
ord-break:break-word"><span style=3D"white-space:normal;word-break:break-wo=
rd">=E8=A7=A3=E5=86=B3=E8=BF=99=E4=BA=9B=E9=97=AE=E9=A2=98=E5=AF=B9=E4=BA=
=8E=E6=88=91=E4=BB=AC=E7=9A=84=E9=A1=B9=E7=9B=AE=E8=83=BD=E5=90=A6=E6=88=90=
=E5=8A=9F=E8=87=B3=E5=85=B3=E9=87=8D=E8=A6=81=E3=80=82=E4=BB=BB=E4=BD=95=E8=
=83=BD=E5=A4=9F=E5=B8=AE=E5=8A=A9=E6=88=91=E4=BB=AC=E5=89=8D=E8=BF=9B=E7=9A=
=84=E5=BB=BA=E8=AE=AE=E6=88=96=E4=BF=A1=E6=81=AF=EF=BC=8C=E6=88=91=E4=BB=AC=
=E5=B0=86=E4=B8=8D=E8=83=9C=E6=84=9F=E6=BF=80=E3=80=82</span></p><p style=
=3D"white-space:normal;word-break:break-word"><strong style=3D"white-space:=
normal;word-break:break-word"><span style=3D"white-space:normal;word-break:=
break-word">=E3=80=90=E6=88=91=E4=BB=AC=E7=9A=84=E7=8E=AF=E5=A2=83=E4=BF=A1=
=E6=81=AF=E3=80=91</span></strong></p><ul style=3D"white-space:normal;word-=
break:break-word"><li style=3D"white-space:normal;word-break:break-word"><p=
 style=3D"white-space:normal;word-break:break-word"><strong style=3D"white-=
space:normal;word-break:break-word"><span style=3D"white-space:normal;word-=
break:break-word">DPDK =E7=89=88=E6=9C=AC=EF=BC=9A25.07</span></strong></p>=
</li><li style=3D"white-space:normal;word-break:break-word"><p style=3D"whi=
te-space:normal;word-break:break-word"><strong style=3D"white-space:normal;=
word-break:break-word"><span style=3D"white-space:normal;word-break:break-w=
ord">=E7=BD=91=E5=8D=A1=E5=9E=8B=E5=8F=B7=EF=BC=9A</span></strong><code sty=
le=3D"white-space:normal;word-break:break-word"><span style=3D"white-space:=
normal;word-break:break-word">Chelsio T520-CR</span></code></p></li><li sty=
le=3D"white-space:normal;word-break:break-word"><p style=3D"white-space:nor=
mal;word-break:break-word"><strong style=3D"white-space:normal;word-break:b=
reak-word"><span style=3D"white-space:normal;word-break:break-word">=E6=93=
=8D=E4=BD=9C=E7=B3=BB=E7=BB=9F=E4=B8=8E=E5=86=85=E6=A0=B8=E7=89=88=E6=9C=AC=
=EF=BC=9ATinycore64 16.0=C2=A0 kernel 6.6.63</span></strong></p></li></ul><=
p style=3D"white-space:normal;word-break:break-word"><span style=3D"white-s=
pace:normal;word-break:break-word">=E6=84=9F=E8=B0=A2=E6=82=A8=E7=9A=84=E6=
=97=B6=E9=97=B4=E5=92=8C=E5=85=B3=E6=B3=A8=EF=BC=8C=E6=88=91=E4=BB=AC=E6=80=
=A5=E5=88=87=E5=9C=B0=E6=9C=9F=E5=BE=85=E6=82=A8=E7=9A=84=E5=9B=9E=E5=A4=8D=
=EF=BC=81</span></p><p style=3D"white-space:normal;word-break:break-word"><=
span style=3D"white-space:normal;word-break:break-word">=E6=AD=A4=E8=87=B4=
=EF=BC=8C</span></p><p style=3D"white-space:normal;word-break:break-word"><=
span style=3D"white-space:normal;word-break:break-word">=E6=95=AC=E7=A4=BC=
=EF=BC=81</span></p></span><br></div></div></blockquote></div>

--000000000000c4b91a06407cdcca--
